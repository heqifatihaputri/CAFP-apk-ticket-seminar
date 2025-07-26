class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :event
  belongs_to :ticket_stock

  attr_accessor :skip_order_validation

  before_save   :update_cart

  after_destroy  :less_cart_items_count

  scope :order_by_latest,    -> { order(created_at: :desc) }

  def self.add_to_cart_item(resource_detail, skip_exist_item = false)
    cart_item = new
    cart_item.assign_attributes(resource_detail)

    unless skip_exist_item
      exist_item = cart_item.find_exist_item
      if exist_item.present?
        exist_item.count_cart_items_quantity(resource_detail[:quantity].to_i)

        return exist_item
      end
    end

    cart_item
  end

  def count_cart_items_quantity(quantity)
    self.update(quantity: self.quantity + quantity)
  end

  def self.update_cart_item(cart_item, quantity)
    if cart_item.update(quantity: quantity)
    # if cart_item.update(quantity: quantity, price: cart_item.total_item_calculate(quantity))
      return true
    else
      return cart_item.errors.full_messages.to_sentence
    end
  end

  def self.total_cart_item(items)
    items.map { |item| item.ticket_stock.price * item.quantity }.sum
  end

  # def total_item_calculate(qty = nil)
  #   if qty.blank?
  #     return self.price unless self.new_record?
  #   end
  #   price * qty
  # end

  def find_exist_item
    cart.cart_items.where(ticket_stock_id: ticket_stock_id).first
  end

  private

  def update_cart
    cart.reload
    cart.cart_items_count -= quantity_was unless new_record?
    cart.cart_items_count += quantity
    cart.save
  end

  def less_cart_items_count
    return nil if cart.blank?

    cart.update(cart_items_count: cart.cart_items_count - quantity)
  end
end
