class OrderTemp < ApplicationRecord
  include AASM

  belongs_to :user
  has_many   :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  attr_accessor :send_status_order

  aasm(column: 'status') do
    error_on_all_events :handle_error_for_all_events

    state :pending, initial: true
    state :cancel, :expired, :submit

    event :proses_submit do
      transitions from: %i[pending cancel expired submit], to: :submit
    end

    event :process_cancel do
      transitions from: %i[pending cancel free], to: :cancel

      success do
        process_cancel_after
      end
    end

    event :proses_expired do
      transitions from: %i[pending expired], to: :expired
    end
  end

  def paid_by_balance?
    send_status_order.eql?('paid_by_balance')
  end

  def free?
    send_status_order.eql?('free')
  end

  def build_order_temp_data(cart_item_ids, params)
    ActiveRecord::Base.transaction do
      payment_check   = params[:payment_check]
      current_balance = user.current_balance

      if cart_item_ids.blank?
        errors.add(:base, 'Something went wrong, please check your cart again...')
        return self
      end

      out_of_stocks = check_item_stock(cart_item_ids)
      if out_of_stocks.present?
        errors.add(:base, "#{out_of_stocks.to_sentence} is out of stock. Please try to reduce the stock quantity or remove product from cart")
        return self
      end

      # Move cart items to order items
      self.order_items_attributes = assign_order_items(cart_item_ids)
      self.total                  = counting_amount(self.order_items)

      user_profile = user.user_profile
      self.phone_number   = user_profile.mobile_phone
      self.recepient_name = user_profile.full_name
      self.payment_method = payment_check

      case payment_method
      when 'e_wallet'
        if current_balance.current_mutation < total
          errors.add(:base, 'Your e-wallet less amount, please top up your e-wallet ')
          return self
        end
        self.send_status_order = 'paid_by_balance'
      when 'free'
        self.send_status_order = 'free'
      when 'credit'
        use_balance_txn(current_balance) if params[:use_balance].present?
      end

      if save
        if paid_by_balance? || free?
          build_order = Order.build_order_data(self)

          if !build_order[:result]
            if build_order[:errors]
              errors.add(:base, errors)
            else
              errors.add(:base, "Create order and Payment failed! Order pending with e-wallet payment. ")
            end
            self.update(status: "pending")
            return self
          end
        elsif params[:use_balance].present?
          balance_opt = { description: "Order Temp ID: ##{id}" }
          balance_out = current_balance.balance_out(use_balance_amount, self, balance_opt)

          if balance_out.errors.present?
            insufficient_balance(balance_out)
            errors.add(:base, "E-wallet payment failed! Order pending with credit payment. ")
            return self
          end
        end

        remove_cart_items(cart_item_ids)
      end

      self
    end
  end

  def check_item_stock(item_ids, item_type = "CartItem")
    if item_type.eql?("CartItem")
      items = CartItem.where(id: item_ids)
    else
      items = OrderItem.where(id: item_ids)
    end

    out_of_stocks = []

    items.each do |item|
      if item.ticket_stock&.out_of_stock?(item.quantity)
        out_of_stocks << item.ticket_stock.name
      end
    end

    return out_of_stocks
  end

  def counting_amount(order_items)
    order_items.map{|item| item.ticket_stock.price * item.quantity}.sum.to_f
  end

  def use_balance_txn(balance_amount)
    self.use_balance_amount = balance_amount
    self.use_balance = true
  end

  def assign_order_items(cart_item_ids)
    cart_items = CartItem.where(id: cart_item_ids)

    item_attributes = []

    cart_items.each do |cart_item|
      price = cart_item.ticket_stock.price
      item_attrs = cart_item.attributes.merge(price: price.to_f)
      item_attributes << item_attrs.symbolize_keys.except(:id, :cart_id, :created_at, :updated_at)
    end

    return item_attributes
  end

  def remove_cart_items(cart_item_ids)
    cart_items = CartItem.where(id: cart_item_ids)
    cart_items.destroy_all
  end

  def insufficient_balance(balance_out)
    update(use_balance: false, use_balance_amount: 0, payment_method: 'e_wallet', status: 'pending')
    errors.add(:base, "#{balance_out.errors.full_messages.to_sentence}. Order pending with e-wallet payment.")
  end

  def after_create_order
    # Substract Stock
    TicketStock.update_stock_quantity(order_items)

    # Clear order temp relation
    order_items.update_all(order_temp_id: nil)

    # Destroy Order Temp
    destroy!
  end

end
