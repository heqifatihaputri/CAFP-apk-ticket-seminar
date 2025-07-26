class TicketStock < ApplicationRecord
  belongs_to :event
  belongs_to :admin, optional: true

  has_many   :order_items
  has_many   :tickets, dependent: :destroy

  attr_accessor :plus_qty, :minus_qty

  before_create  :set_total_stock
  before_update  :update_total_stock
  before_destroy :check_purchased_tickets

  scope :live, -> { where(go_live: true) }


  def active?
    return false if start_sale.blank? || end_sale.blank?

    past_today   = start_sale.try(:past?) || start_sale.try(:today?)
    future_today = end_sale.try(:future?) || end_sale.try(:today?)
    date_valid   = end_sale > start_sale || end_sale == start_sale

    past_today && future_today && date_valid
  end

  def out_of_stock?(qty)
    qty.to_i > quantity.to_i
  end

  def set_total_stock
    self.total_stock = self.quantity
  end

  def update_total_stock
    if plus_qty.present?
      self.total_stock = total_stock + plus_qty.to_i
      self.quantity    = quantity + plus_qty.to_i
    elsif minus_qty.present?
      minus_stock = quantity - minus_qty.to_i

      if minus_stock < 0
        errors.add(:base, 'Minus stock failed!')
        return self
      end
      self.total_stock = total_stock - minus_qty.to_i
      self.quantity    = minus_stock
    end
  end

  def update_stock_sold
    self.with_lock do
      get_success_orders = self.order_items.success_orders
      
      self.sold_quantity = get_success_orders.map(&:quantity).sum
      self.save(validate: false)
    end
  end

  def self.update_stock_quantity(order_items)
    order_items.each do |item|
      stock = item.ticket_stock
      stock.with_lock do
        stock.quantity = stock.quantity.to_i - item.quantity
        stock.save(validate: false)
      end
    end
  end

  def self.top_selling
    date = Date.today
    TicketStock.joins(order_items: [order: :invoice]).references(:invoice)
      .where("invoices.status =(?) AND paydate BETWEEN (?) AND (?)", "success", date.beginning_of_month.beginning_of_day, date.
        end_of_month.end_of_day).order(sold_quantity: :desc).uniq.take(5)
  end

  def check_purchased_tickets
    if OrderItem.where(ticket_stock: self).present?
      errors.add(:base, "You don't allowed to delete this ticket stock!")
      throw(:abort)
    end
  end
end
