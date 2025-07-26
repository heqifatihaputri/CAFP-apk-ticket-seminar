class Order < ApplicationRecord
  include AASM

  belongs_to :user

  has_one    :invoice, dependent: :destroy

  has_many   :order_items

  accepts_nested_attributes_for :order_items, allow_destroy: true

  aasm(column: 'status') do
    error_on_all_events :handle_error_for_all_events

    state :success, initial: true
    state :success, :paid_by_balance, :free

    event :proses_success do
      transitions from: %i[success paid_by_balance success], to: :success
    end

    event :proses_paid_by_balance do
      transitions from: %i[success success paid_by_balance], to: :paid_by_balance
    end

    event :proses_free do
      transitions from: %i[success free], to: :free
    end

    event :proses_refund do
      transitions from: %i[success refund], to: :refund
    end
  end

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  after_create :generate_order_uid

  scope :includes_invoice, -> { includes(:invoice).where.not(invoices: {id: nil}) }
  scope :success_invoices, -> { includes_invoice.where(invoices: {status: "success"}) }
  scope :success_orders,   -> { success_invoices.where(status: Order.success_statuses) }
  scope :without_e_wallet, -> { where.not(orders: {status: 'paid_by_balance'}) }
  scope :with_eager_load,  -> { includes(:invoice, user: [:user_profile]) }
  scope :order_by_invoice, -> { includes(:invoice).order("invoices.paydate DESC") }

  def generate_order_uid
    self.order_uid = "#{created_at.strftime("%d%m%Y")}#{id}"
    self.save(validate: false)
  end

  def order_description
    @order_description || "Order with ID #{id} from #{recepient_name}"
  end

  def paid_with_balance?
    payment_method.eql?('e_wallet') && invoice.success?
  end

  def self.success_statuses
    ["success", "paid_by_balance", "free"]
  end

  def order_success?
    Order.success_statuses.include?(self.status)
  end

  def self.build_order_data(order_temp)
    ActiveRecord::Base.transaction do
      order_items = order_temp.order_items

      out_of_stocks = check_item_stock(order_items)
      if out_of_stocks.present?
        errors = "#{out_of_stocks.to_sentence} is out of stock. Please try to reduce the stock quantity or remove product from cart"
        return { result: false, errors: errors }
      end

      order = order_temp.user.orders.new
      order.assign_attributes(order_temp.attributes.symbolize_keys.except(:created_at, :updated_at, :status))
      order.status = "paid_by_balance" if order_temp.paid_by_balance?
      order.status = "free" if order_temp.free?

      return { result: false } unless order.save

      unless Invoice.store_data_invoice(order)
        return { result: false }
        delete_order
      end

      result  = if order.success? # payment with credit
                  { result: true, order: order }
                else
                  { result: order.balance_payment, order: order }
                end

      if result[:result]
        # Assign order items to order
        order_temp.order_items.update_all(order_id: order.id)

        # Update ticket stock sold
        order.update_ticket_stock_sold

        # Generate ticket
        order.generate_ticket_links
      end

      return result
    end
  end

  def self.check_item_stock(items)
    out_of_stocks = []

    items.each do |item|
      if item.ticket_stock&.out_of_stock?(item.quantity)
        out_of_stocks << item.ticket_stock.name
      end
    end

    return out_of_stocks
  end

  def balance_payment
    balance_opt = { description: "Order Temp ID: ##{id}" }
    balance_out = user.current_balance.balance_out(total, self, balance_opt)

    if balance_out.errors.present?
      delete_order
      return false
    else
      true
    end
  end

  def delete_order
    destroy!
  end

  def update_ticket_stock_sold
    self.order_items.each do |order_item|
      order_item.calculate_ticket_stock_sold
    end
  end

  def generate_ticket_links
    order_items.map{|order_item| Ticket.generate_ticket(order_item)}
  end

  def self.ransackable_associations(auth_object = nil)
    self.reflect_on_all_associations.map(&:name).map(&:to_s)
  end

end
