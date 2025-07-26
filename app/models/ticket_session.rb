class TicketSession < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  belongs_to :event
  belongs_to :event_session

  has_one    :last_ticket, class_name: "Ticket", foreign_key: "last_ticket_session_id", dependent: :nullify

  after_save    :update_last_ticket_session
  after_destroy :update_last_ticket_session, :clean_api_response

  scope :order_latest_created,    -> { order(created_at: :desc) }
  scope :scan_in_sessions,        -> { where.not(in_time: nil) }
  scope :scan_out_sessions,       -> { where(out_time: nil) }
  scope :must_scan_out_sessions,  -> { scan_in_sessions.scan_out_sessions }
  scope :with_out_time,           -> { where.not(out_time: nil).order(out_time: :desc) }
  scope :latest_visitor_sesions,  -> ( event_session ) { where(event_session: event_session).order_latest_created }

  def update_last_ticket_session
    last_session = ticket.ticket_sessions.order_latest_created.first

    unless ticket.last_ticket_session.eql?(last_session)
      ticket.update(last_ticket_session: last_session)
    end

    if last_session.blank?
      # after destroy
      ticket.update(api_response: {})
    end
  end

  def clean_api_response
    if ticket.ticket_sessions.blank?
      ticket.reload.update(api_response: {})
    end
  end

  def self.scan_in(ticket, visitor_id_in)
    last_ticket_session = ticket.ticket_sessions.must_scan_out_sessions.find_by(ticket: ticket)

    if last_ticket_session.present?
      last_ticket_session.errors.add(:base, 'This ticket has scanned in current session, please scan out at the exits before scanning in again.')
      return last_ticket_session
    end

    event = ticket.event
    event_session  = EventSession.current_event_session(event)
    ticket_session = event.ticket_sessions.build(ticket: ticket)

    if event_session.blank? || !event.is_started?
      ticket_session.errors.add(:base, 'This event is not started or has ended')
      return ticket_session
    end

    ticket_session.event   = event
    ticket_session.user    = ticket.ownership
    ticket_session.in_time = DateTime.now
    ticket_session.visitor_id_in = visitor_id_in
    ticket_session.event_session = event_session
    
    unless ticket_session.save
      ticket_session.errors.add(:base, 'Something went wrong! Please try again.')
    end

    return ticket_session
  end

  def scan_out(visitor_id)
    event_session  = EventSession.current_event_session(event)

    if event_session.blank?
      errors.add(:event, 'no longer in session! The session is not started yet or already end.')
      return self
    end

    if in_time.blank?
      errors.add(:base, 'No last attendance session! Please scan in before you scanning out.')
      return self
    end

    if !visitor_id_in.eql?(visitor_id)
      errors.add(:base, 'This device does not match with any scan in data.')
      return self
    end

    if out_time.present?
      errors.add(:user, 'has scanned out! Please scan in before you scanning out.')
      return self
    end

    if update(out_time: DateTime.now, visitor_id_out: visitor_id)
      ticket.update(last_ticket_session_id: nil)
    else
      errors.add(:base, 'Something went wrong! Please try again.')
    end

    return self
  end

  def self.scan_out_all(event)
    ticket_sessions = event.ticket_sessions.scan_out_sessions.scan_in_sessions

    ticket_sessions.each do |ticket_session|
      if ticket_session.update(out_time: DateTime.now)
        ticket_session.ticket.update(last_ticket_session_id: nil)
      end
    end      
  end

  def update_api_response(current_visitor_id, msg_response)
    current_time = DateTime.now.to_s
    api_response = ticket.api_response
    api_response[:last_request] = current_time
    api_response[current_visitor_id] = msg_response.merge(last_updated: current_time)

    ticket.reload.update(api_response: api_response)
  end
end
