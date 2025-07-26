class CertificationController < ApplicationController
  layout 'application_public_page'
  # layout 'certification_layout'
  # layout :false

  def index
    @ticket = Ticket.find(params[:ticket_id])
    @event  = @ticket.event
    @ownership = @ticket.ownership
    @profile   = @ownership.user_profile
    @name      = @ticket.attendee_name || @profile
  end
end