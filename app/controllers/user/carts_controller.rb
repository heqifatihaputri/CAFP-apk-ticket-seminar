# frozen_string_literal: true

class User::CartsController < User::BaseController
  include Modules::Crudable

  before_action :get_cart
  before_action :get_cart_items, only: [:index, :update_price_cart_item, :checkout]
  before_action :get_cart_item, only: %i[update_price_cart_item]
  before_action :set_breadcrumb

  breadcrumb "Cart", :user_carts_path
  breadcrumb "Checkout", :checkout_user_carts_path, only: :checkout

  def index
    @name_page = 'Cart'
  end

  def create
    cart_item = @cart
  end

  def add_to_cart
    @cart_items = @cart.build_cart_item_param(params)

    if @cart_items.eql?(true)
      redirect_to user_carts_path, notice: "Add to cart was successfully"
    else
      redirect_to request.referrer, alert: @cart_items.to_sentence
    end
  end

  def make_order_temp
    cart_item_ids = params[:checkout].present? ? params[:checkout][:cart_item_ids] : []

    @order_temp = current_user.order_temps.new
    @order_temp = @order_temp.build_order_temp_data(cart_item_ids, params)

    if @order_temp.errors.blank?
      @order_temp.after_create_order
      redirect_to user_orders_path, notice: 'Order and payment successfully!'
    else
      redirect_to checkout_user_carts_path, alert: @order_temp.errors.full_messages.to_sentence
    end
  end

  def check_order_status
    @order = Order.find(params[:order_id])

    if @order.cancel?
      return redirect_to user_orders_url, alert: "Order has been canceled!"
    end

    out_of_stocks = @order.check_item_stock(@order.order_item_ids, "OrderItem")

    if out_of_stocks.present?
      msg_txt = out_of_stocks.count > 1 ? "Some Items (#{out_of_stocks.to_sentence} are)" : "Item #{out_of_stocks.to_sentence} is"
      return redirect_to user_orders_url, alert: "#{msg_txt} out of stock! You're not allowed to complete this payment."
    end
  end

  def set_message
    redirect_to user_carts_path, alert: 'cart is empty'
  end

  def checkout
    @name_page = 'Checkout'
    @total     = CartItem.total_cart_item(@cart_items).to_f
    @current_mutation = current_user.current_balance.current_mutation
  end

  def update_quantity
    params_cart_item = params[:cart_item]
    count = params_cart_item[:id].keys.count - 1
    (0..count).each do |i|
      id = params_cart_item[:id][i.to_s]
      cart_item = CartItem.find_by(id: id)
      redirect_to user_carts_path, alert: "Edit Order data not allowed!" and return if cart_item.blank?

      quantity    = params[:cart_item][:quantity][i.to_s]
      @cart_items = CartItem.update_cart_item(cart_item, quantity)
    end

    if @cart_items.eql?(true)
      redirect_to checkout_user_carts_path(promo_id: @promo)
    else
      redirect_to user_carts_path, alert: @cart_items
    end
  end

  def detect_current_user
    if current_user.blank?
      user = @order.user
      sign_in(:user, user)
    end
  end

  def update_price_cart_item
    if @cart_item.present?
      @idx = params[:idx].to_i
      @quantity      = params[:quantity].to_i
      @price         = @cart_item.ticket_stock.price.to_f
      @hide_total    = true

      @cart_item.update(quantity: @quantity)
    end

    respond_to do |format|
      format.js
      format.any  { render json: { message: "Invalid Request" } }
    end
  end

  private

  def get_cart
    @cart = current_user.cart
  end

  def get_cart_items
    @cart_items = @cart.cart_items.includes(ticket_stock: [:event]).order_by_latest
  end

  def get_cart_item
    @cart_item = CartItem.find_by(id: params[:cart_item_id])
  end

  def set_breadcrumb
    default_breadcrumb
  end
end
