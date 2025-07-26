class Invoice < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :order, optional: true

  aasm(column: 'status') do
    error_on_all_events :handle_error_for_all_events

    state :success, initial: true
    state :success, :failed

    event :proses_success do
      transitions from: %i[failed success], to: :success
    end

    event :proses_failed do
      transitions from: %i[success failed], to: :failed
    end
  end

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  after_create :generate_invoice_uid

  def generate_invoice_uid
    self.invoice_uid = "#{created_at.strftime("%d%m%Y")}#{id}"
    self.save(validate: false)
  end

  # scope :success_and_refund,   -> { status_success.or(includes(:order).where(orders: {status: "refund"})) }
  # scope :without_tqg_balance,  -> { includes(:order).where.not(orders: {status: 'paid_by_balance'}) }
  scope :except_free_payments, -> { where("invoices.total IS NOT NULL AND invoices.total > (?)", 0) }
  scope :sales_by_month, -> (date) { success.where("paydate BETWEEN (?) AND (?)", date.beginning_of_month.beginning_of_day, date.end_of_month.end_of_day) }
  scope :order_by_payment_date, -> { order(paydate: :desc) }

  def self.store_data_invoice(order)
    # Create invoice after order is successfully
    invoice = order.build_invoice
    invoice.user    = order.user
    invoice.total   = order.total
    invoice.paydate = DateTime.now
    invoice.save
  end

  def update_invoice(order, callback_params, callback_status)
    # Update invoice after payment is successfully
    if callback_status.eql?(00)
      self.detail   = callback_params.permit!.to_h rescue {}
      self.trans_id = self.detail[:tranID]
    end
  end

  # def invoice_id
  #   "#{paydate.strftime("%d%m%Y")}#{id}"
  # end

  def self.sales_increase(now, before)
    return "0%" if (now < before) || before.eql?(0)

    "#{(before / now) * 100}%"
  end
end
