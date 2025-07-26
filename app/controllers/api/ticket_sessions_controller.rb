module Api
  class TicketSessionsController < Api::BaseApiController
    skip_before_action :verify_authenticity_token

    before_action :get_ticket, only: [:scan_in, :scan_out, :get_ticket_alert]

    def scan_in
      ticket_session = TicketSession.scan_in(@ticket, params[:visitor_id])

      if ticket_session.errors.blank?
        msg = "Scan In Successfully"
        msg_response = {message: msg, status: "success"}
        render json: ticket_session, message: msg, serializer: Api::TicketSessionSerializer, status: 200
      else
        msg_response = {message: ticket_session.errors.full_messages.to_sentence, status: "failed"}
        render json: ticket_session, serializer: Api::TicketSessionSerializer, status: :bad_request
      end

      ticket_session.update_api_response(params[:visitor_id], msg_response)
    end

    def get_ticket_alert
      alert_data = @ticket.get_scan_ticket_alert(params[:visitor_id])

      respond_to do |format|
        format.json { render json: alert_data }
        format.any  { render json: { message: "Invalid Request" } }
      end
    end

    def scan_out
      ticket_session = @ticket.last_ticket_session || TicketSession.new(ticket: @ticket, event: @ticket.event)
      scan_out       = ticket_session&.scan_out(params[:visitor_id])

      if scan_out.errors.blank?
        msg = "Scan Out is Successfully!"
        msg_response = {message: msg, status: "success"}
        render json: ticket_session, message: msg, scan_type: "out", serializer: Api::TicketSessionSerializer, status: 200
      else
        msg_response = {message: ticket_session.errors.full_messages.to_sentence, status: "failed"}
        errors_msg(scan_out)
      end

      ticket_session.update_api_response(params[:visitor_id], msg_response)
    end

    private

    def get_ticket
      @ticket = Ticket.find_by(id: params[:ticket_id])
      record_not_found_v1(Event) and return if @ticket.blank?
    end
  end
end
