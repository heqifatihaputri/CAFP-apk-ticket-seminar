class Ticket < ApplicationRecord
  include UrlChecker

  belongs_to :event
  belongs_to :ownership, class_name: "User", foreign_key: "ownership_id", optional: true
  belongs_to :order_item
  belongs_to :ticket_stock
  belongs_to :last_ticket_session, class_name: "TicketSession", foreign_key: "last_ticket_session_id", optional: true

  has_many   :ticket_sessions, dependent: :destroy

  serialize :api_response, Hash

  # validate  :all_tickets_generated

  scope :order_start_time, -> { includes(:event).order("event.start_time") }

  def all_tickets_generated
    return true if skip_ticket_validation
    if order_item.tickets.reload.count.to_i >= order_item.quantity.to_i
      errors.add(:base, 'All links has been registered')
      false
    end
  end

  def get_scan_ticket_alert(visitor_id)
    last_request_time = api_response[:last_request]&.to_datetime
    return {} if last_request_time.blank?

    return scan_ticket_msg(visitor_id) if (DateTime.now-3.minutes) <= last_request_time
    return {}
  end

  def scan_ticket_msg(visitor_id)
    current_time  = DateTime.now
    event_session = EventSession.current_event_session(event)
    last_session  = ticket_sessions.where("visitor_id_out =? OR visitor_id_in =?", visitor_id, visitor_id).
                    latest_visitor_sesions(event_session).first
    limit_time    = (current_time < (api_response[visitor_id][:last_updated].to_datetime + 2.minute)) rescue false
    data_response = api_response[visitor_id]

    if data_response.present? && limit_time
      failed_status = data_response[:status].eql?("failed")
      alert_label   = data_response[:status].eql?("success") ? "success" : failed_status ? "danger" : "warning"
      alert_msg     = failed_status ? "Scan In Failed!" : data_response[:message]
      return { alert_label: alert_label, alert_msg: alert_msg, failed_reason: (failed_status ? data_response[:message] : "") }
    else
      return {}
    end
  end

  def allow_print_certificate?
    ticket_sessions.scan_in_sessions.with_out_time.present?
  end

  def get_user_uid
    order_item.order.user.user_profile.user_uid rescue nil
  end

  # START CLASS METHOD
  class << self
    def generate_ticket(order_item, options = {})
      event           = order_item.ticket_stock.event
      remark          = options[:remark]
      ticket_arr      = []
      errors          = []
      ticket_attendee = []

      tickets_data = Ticket.where(order_item: order_item).order(:id)
      gen_total    = order_item.quantity.to_i - tickets_data.count

      gen_total.times do
        order   = order_item.order
        ticket  = TicketGenerator.create(event.id, order_item, {remark: remark})

        if ticket.errors.present?
          errors += ticket.errors.full_messages
        else
          link_index  = tickets_data.ids.find_index(ticket.id)+1
          split_email = ticket.ownership.email.split("@")
          fake_email  = "#{split_email.first}+tix00#{link_index}+#{ticket.id}@#{split_email.last}"
          ticket.update(fake_email: fake_email)
          ticket_arr << ticket
        end if ticket.present?
      end

      { tickets: ticket_arr, errors: errors }
    end
  end

end
