# frozen_string_literal: true

class User::OrdersController < User::BaseController
  before_action :set_tab, only: [:index]
  before_action :get_orders, only: :index
  # before_action :search_product, only: :index
  before_action :set_breadcrumb

  def index
    @tab = params[:tab]
    @name_page = 'My Orders'
    @orders    = @orders.page(params[:page])
  end

  def show
    @name_page   = 'My Order Detail'
    @order       = Order.find(params[:id])
    @order_items = @order.order_items
    @invoice     = @order.invoice

    breadcrumb @name_page, user_order_path(@order)
  end

  private

  def set_tab
    params[:tab] ||= "my-order"
  end

  def get_orders
    @orders = current_user.orders.includes_invoice.order(id: :desc)
  end

  def search_product
    params[:q] ||= {}
    date_range = params[:q][:created_at_filter_between]
    if date_range.present?
      params[:q][:created_at_filter_between] = nil if date_range.split(' - ').count < 2
    end

    @q = @orders.ransack(params[:q])
    @orders = @q.result
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb 'My Orders', :user_orders_path
  end
end
