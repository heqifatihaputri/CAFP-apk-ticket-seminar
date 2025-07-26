module TicketGenerator
  extend ActiveSupport::Concern
  # included do
  # end

  def self.create(event_id, order_item, options = {})
    event  = Event.find_by(id: event_id)
    return if event.blank?

    ticket = Ticket.new
    Ticket.transaction do
      ticket.event        = event
      ticket.code         = options[:code] || SecureRandom.hex(16).upcase
      ticket.remark       = assign_remark(options)
      ticket.order_item   = order_item
      ticket.ticket_stock = order_item.ticket_stock
      ticket.ownership    = order_item.order.user
      generate_ticket_token(ticket)

      return ticket unless ticket.save
    end

    ticket
  end

  def self.assign_remark(options = {})
    return options[:remark] if options[:remark].present?
    return nil if options[:code].blank?

    prev = Ticket.find_by(code: options[:code])
    prev.present ? prev.remark : nil
  end

  def self.generate_ticket_token(ticket)
    loop do
      link_token = SecureRandom.hex(6)
      ticket.link_token = SecureRandom.hex(6)

      unless Ticket.where(link_token: link_token).any?
        ticket.link_token = link_token
        break
      end
    end

    ticket
  end
end
