class Admin::TicketStocksController < Admin::BaseAdminController
  include Modules::Crudable

  before_action :get_event
  before_action :set_redirect_path, except: [:destroy]
  before_action :set_breadcrumb

  def new
    super do
      breadcrumb "New Ticket Stock", "#"
    end
  end

  def edit
    super do
      breadcrumb "Edit Ticket Stock", "#"
    end
  end

  def update
    super do
      @ticket_stock.plus_qty  = params[:plus_qty]
      @ticket_stock.minus_qty = params[:minus_qty]
    end
  end

  def show
    super do
      @name_page = 'Stock Details'

      breadcrumb @name_page, admin_event_ticket_stock_path(@event, @ticket_stock)
    end
  end

  def destroy
    @ticket_stock = TicketStock.find(params[:id])
    if @ticket_stock.destroy
      flash[:notice] = "Ticket Stock deleted successfully."
    else
      flash[:alert] = @ticket_stock.errors.full_messages.to_sentence
    end
    redirect_to admin_event_path(@event, tab: "ticket-stock"), status: :see_other and return
  end

  private

  def get_event
    @event = Event.find(params[:event_id])
  end

  def set_redirect_path
    self.redirect_path = admin_event_path(@event, tab: "ticket-stock")
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "Event Data", :admin_events_path
    breadcrumb "Event Details", admin_event_path(@event, tab: "ticket-stock")
  end
end
