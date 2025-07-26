class Admin::EventsController < Admin::BaseAdminController
  include Modules::Crudable
  include Modules::GivenParamsFileable

  before_action :form_collection, only: %i[new edit create update index]
  before_action :set_search, only: %i[index]
  before_action :set_breadcrumb

  self.additional_parameters = [
    images_attributes: %i[image _destroy id]
  ]

  def index
    @name_page = "Event Data"
    @events    = @events.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    super do
      breadcrumb "New Event", "#"
    end
  end

  def edit
    super do
      breadcrumb "Event Details", admin_event_path(@event)
      breadcrumb "Edit Event", "#"
    end
  end

  def show
    super do
      @name_page = "Event Details"
      breadcrumb @name_page, admin_event_path(@event)

      @tab = params[:tab] || 'event-overview'
      ticket_stocks  if @tab.eql?('ticket-stock')
      event_sessions if @tab.eql?('event-session')

      @images = @event.images
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "Event deleted successfully."
    else
      flash[:alert] = "You don't allowed to delete this event!"
    end
    redirect_to admin_events_path, status: :see_other and return
  end

  def ticket_stocks
    @stocks = @event.ticket_stocks
  end

  def event_sessions
    @event_sessions = @event.event_sessions
  end

  def set_search
    params[:q] ||= {}

    if params[:date_range].present?
      split_date = params[:date_range].split(" - ")
      params[:q][:start_time_gteq] = Date.strptime(split_date.first, '%d/%m/%Y').beginning_of_day
      params[:q][:start_time_lteq] = Date.strptime(split_date.last, '%d/%m/%Y').end_of_day
    end

    @q      = Event.ransack(params[:q])
    @events = @q.result.order_start_time
  end

  private

  def form_collection
    @venues        = build_select_options(Venue.all)
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "Event Data", :admin_events_path
  end
end
