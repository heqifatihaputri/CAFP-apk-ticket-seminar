# frozen_string_literal: true

class User::OrderTempsController < User::BaseController
  before_action :set_tab, only: [:index]
  before_action :get_order_temps, only: :index
  before_action :set_breadcrumb

  def index
    @tab = params[:tab]
    @name_page = 'Pending Orders'
    @orders    = @orders.page(params[:page])
  end

  def show
    @name_page  = 'Pending Order Detail'
    @order       = OrderTemp.find(params[:id])
    @order_items = @order.order_items

    breadcrumb @name_page, user_order_temp_path(@order)
  end

  # def cancel_process
  #   @order = Order.find(params[:id])
  #   if @order.process_cancel!
  #     flash[:notice] = 'Order has been canceled!'
  #   else
  #     flash[:alert] = @order.errors.full_messages.to_sentence
  #   end

  #   redirect_to request.referer
  # end

  private

  def set_tab
    params[:tab] ||= "pending-order"
  end

  def get_order_temps
    @orders = current_user.order_temps.order(id: :desc)
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
    breadcrumb 'Pending Orders', :user_order_temps_path
  end
end
