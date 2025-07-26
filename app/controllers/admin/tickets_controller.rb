class Admin::TicketsController < Admin::BaseAdminController
  before_action :get_event
  before_action :set_search
  before_action :set_breadcrumb

  def index
    @tickets = @tickets.page(params[:page])
  end

  def set_search
    params[:q] ||= {}

    @q       = Ticket.where(event_id: params[:event_id]).ransack(params[:q])
    @tickets = @q.result
  end

  private

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "Event Data", :admin_events_path
    breadcrumb "Event Details", admin_event_path(@event, tab: "ticket-stock")
    breadcrumb "All Tickets", "#"
  end

  def get_event
    @event = Event.find(params[:event_id])
  end
end
