class User::TicketsController < User::BaseController
  # include ApplicationHelper
  include Modules::TicketLinkAccess

  before_action :set_breadcrumb
  before_action :get_ticket_stock, only: [:details]
  before_action :get_ticket, only: [:edit_remark, :update_remark]

  def index
    @name_page = 'My Tickets'
    @tickets   = current_user.my_tickets.group(:ticket_stock).count
    @tickets   = Kaminari.paginate_array(@tickets.to_a).page(params[:page])
  end

  def details
    @name_page = 'Ticket Details'
    breadcrumb @name_page, ticket_details_user_tickets_path(@ticket_stock)

    @event   = @ticket_stock.event
    @venue   = @event.venue
    @tickets = current_user.my_tickets.where(ticket_stock: @ticket_stock)
  end

  def edit_remark
    respond_to do |format|
      format.js { }
    end
  end

  def update_remark
    if @ticket.update(ticket_params)
      flash[:notice] = 'Ticket Info successfully updated'
    else
      flash[:alert] = 'Failed to update Ticket Info'
    end

    respond_to do |format|
      format.js { }
      format.html { redirect_to ticket_details_user_tickets_path(@ticket.ticket_stock_id) }
    end
  end

  # def get_link
  #   order_item = OrderItem.find(params[:id])

  #   if order_item.inventory.event.online_event
  #     generated_link = Ticket.generate_ticket(order_item, current_user)

  #     links = generated_link[:links]
  #     errors = generated_link[:errors]
  #   else
  #     links = nil
  #   end

  #   if links.blank?
  #     flash[:alert] = 'Something went wrong. 0 link created.'
  #   else
  #     flash[:notice] = "#{helpers.pluralize(links.size, 'link')} has been created."
  #   end

  #   unless errors.blank?
  #     flash[:alert] = "#{errors.uniq.to_sentence}"
  #     flash[:alert] += ". #{helpers.pluralize(params[:quantity].to_i - links.size , 'link')} not created."
  #   end

  #   redirect_to user_ticket_url(params[:id])
  # end

  def check_ownership
    if !@ticket&.ownership_account&.eql?(current_account)
      flash[:alert] = 'Ticket not found!'
      redirect_to user_tickets_path and return
    end
  end

  private

  def set_breadcrumb
    default_breadcrumb
    breadcrumb 'My Tickets', :user_tickets_path
  end

  def get_ticket_stock
    @ticket_stock = TicketStock.find(params[:ticket_stock_id])
  end

  def get_ticket
    @ticket = Ticket.find_by(id: params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:id, :remark, :attendee_name)
  end
end
