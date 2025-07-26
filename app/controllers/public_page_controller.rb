class PublicPageController < ApplicationController
  layout 'application_public_page'

  before_action :check_current_sign_in, only: :landing_page
  before_action :get_ticket, only: [:show_event, :scan_physical_ticket]
  before_action :get_event, only: [:show_event, :scan_physical_ticket]
  before_action :check_params_event, only: :show_event
  before_action :redirect_back, only: :scan_physical_ticket

  def landing_page
    if admin_signed_in?
      flash[:alert] = "You're already signed in as an Admin!"
      redirect_to admin_root_path and return
    elsif user_signed_in?
      flash[:alert] = "You're already signed in!"
      redirect_to user_root_path and return
    else
     redirect_to new_user_session_path and return
   end
  end

  def show_event
    @venue = @event.venue
    @ticket_stock = @ticket.ticket_stock
  end

  def scan_physical_ticket
    @event_session = EventSession.current_event_session(@event)
    @last_visitor_sesion = @ticket.ticket_sessions&.latest_visitor_sesions(@event_session).last
  end

  def print_certification
    @ticket  = Ticket.find(params[:ticket_id])
    template = "#{params[:controller]}/certification"

    respond_to do |format|
      format.pdf do
        render pdf: "certification.pdf",
              template: template,
                layout: "layouts/application",
         viewport_size: "1024x768",
          orientation: "Landscape"
      end
    end
  end

  private

  def check_current_sign_in
    if user_signed_in?
      flash[:alert] = "You are already signed in."
      redirect_to root_path
    end
  end

  def check_params_event
    if @event.blank? || @ticket.blank?
      redirect_page = user_signed_in? ? user_root_path : root_path
      redirect_to redirect_page, alert: 'Page Not Found!'
    end
  end

  def get_ticket
    @ticket = Ticket.find_by(link_token: params[:link_token])
  end

  def get_event
    @event  = Event.find_by(id: params[:event_id])
  end

  def redirect_back
    if @ticket.blank?
      flash[:alert] = "Not allowed to access scan ticket page! Invalid ticket link."
      redirect_to user_root_path and return if current_user.present?
      redirect_to show_events_path(@event) and return
    end
  end
end