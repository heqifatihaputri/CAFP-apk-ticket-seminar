class Api::TicketSessionSerializer < Api::ApplicationSerializer
  
  def attributes(attrs, condition)
    if object.errors.blank?
      return session_details
    else
      return error_details
    end
  end

  def session_details(data = {})
    data[:message]            = @instance_options[:message]
    data[:ticket_session_id]  = object.id
    data[:ticket_id]          = object.ticket_id
    data[:scan_in_time]       = datetime_formater(object.in_time.in_time_zone, '%d/%m/%Y %I:%M %p') rescue nil
    data[:scan_out_time]      = datetime_formater(object.out_time.in_time_zone, '%d/%m/%Y %I:%M %p') rescue nil
    main_details(data)
    return data
  end

  def error_details(data = {})
    data[:errors] = object.errors.full_messages.to_sentence
    main_details(data)
    return data
  end

  def main_details(data = {})
    ticket = object.ticket
    event  = object.event
    event_session = object.event_session
    last_ticket_session = ticket&.last_ticket_session

    data[:event_session_id]   = object.event_session_id
    data[:event_session_name] = event_session&.title
    data[:event_name]         = event&.name
    data[:ticket_name]        = ticket.blank? ? nil : ticket&.order_item&.ticket_stock&.name
    data[:visitor_id_in]      = object.visitor_id_in
    data[:visitor_id_out]     = object.visitor_id_out
    data[:full_name]          = ticket&.ownership&.user_profile&.full_name
    data[:attendee_name]      = ticket&.attendee_name
    data[:last_scan_in_time]  = date_formater(last_ticket_session.in_time.in_time_zone, '%d/%m/%Y %I:%M %p') rescue nil
  end
end
