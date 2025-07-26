class OrderItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :order_temp, optional: true
  belongs_to :ticket_stock

  has_many   :tickets, dependent: :destroy

  serialize :product_details, Hash

  before_save   :build_product_details

  scope :success_orders,   -> { joins(order: :invoice).where(orders: {status: Order.success_statuses}, invoices: {status: "success"}) }
  scope :without_e_wallet, -> { joins(:order).where.not(orders: {status: 'paid_by_balance'}) }
  scope :by_event,         -> (event) { joins(ticket_stock: :event).where(events: {id: event.id}) }
  scope :by_date,          -> (start_date, end_date) { joins(:order).where('orders.created_at BETWEEN ? AND ?', start_date, end_date) }

  def build_product_details
    details = { sku: ticket_stock.sku }

    if ticket_stock.event.present?
      details[:event_name]     = ticket_stock.event.name
      details[:ticket_name]    = ticket_stock.name
      details[:description]    = ticket_stock.description
    end

    self.product_details = details
  end

  def calculate_ticket_stock_sold
    self.ticket_stock.update_stock_sold
  end

  def free_item?
    price.eql?(0)
  end
end
