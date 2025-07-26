class User::EventsController < User::BaseController
  before_action :get_events, only: :index
  before_action :get_search_collection, only: :index
  before_action :set_breadcrumb

  def index
    @name_page = 'Event Lists'
    @events    = @events.order_start_time.page(params[:page])
  end

  def show
    @name_page = 'Event Details'
    @event     = Event.find(params[:id])
    breadcrumb @event.name, user_event_path(@event)

    @ticket_stocks  = @event.ticket_stocks.live
    @cart_preview   = current_user.cart
  end

  private

  def get_events
    params[:q] ||= { ticket_start_selling_eq: true }

    @q      = Event.includes(:ticket_stocks).ransack(params[:q])
    @events = @q.result
  end

  def get_search_collection
    @select_status = [['All', ''],['Opened', true],['Closed', false]]
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "Event Lists", :user_events_path
  end
end
