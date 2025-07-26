class Admin::OrdersController < Admin::BaseAdminController

  def index
    params[:q] ||= {}

    if params[:date_range].present?
      split_date = params[:date_range].split(" - ")
      params[:q][:invoice_paydate_gteq] = Date.strptime(split_date.first, '%d/%m/%Y').beginning_of_day
      params[:q][:invoice_paydate_lteq] = Date.strptime(split_date.last, '%d/%m/%Y').end_of_day
    end

    @q      = Order.success_orders.ransack(params[:q])
    @orders = @q.result.with_eager_load.order_by_invoice.page(params[:page])
  end

  def show
    @order   = Order.find(params[:id])
    @user    = @order.user
    @profile = @user.user_profile
    @invoice = @order.invoice
    @order_items = @order.order_items
  end
end
