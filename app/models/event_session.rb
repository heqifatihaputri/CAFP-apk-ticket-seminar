class EventSession < ApplicationRecord
  belongs_to :event

  has_many   :ticket_sessions, dependent: :destroy
  has_many   :tickets, through: :event

  before_save :set_is_current_value
  after_save  :update_is_current, :scan_out_all_ticket_session

  before_destroy :ticket_sessions?, prepend: true

  enum status: [:not_started, :started, :ended]

  scope :without_self, -> (id) { where.not(id: id) }

  def self.current_event_session(event)
    find_by(event: event, status: true, is_current: true)
  end

  def set_is_current_value
    if started?
      self.is_current = true
    else
      self.is_current = false
    end
  end

  def update_is_current
    return unless is_current

    event.event_sessions.without_self(self).each do |event_session|
      event_session.is_current = false

      if event_session.ticket_sessions.blank?
        event_session.status = :not_started
      else
        event_session.status = :ended
      end
      event_session.save
    end

    # clean up api response in all tickets
    tickets.update_all(api_response: {})
  end

  private

  def scan_out_all_ticket_session
    return if ticket_sessions.blank? || !ended?

    TicketSession.scan_out_all(event)
  end

  def ticket_sessions?
    if ticket_sessions.present?
      errors.add(:base, "You don't allowed to delete this event session!")
      throw(:abort)
    end
  end
end
