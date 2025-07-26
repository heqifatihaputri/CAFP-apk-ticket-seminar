class Balance < ApplicationRecord
  belongs_to :user
  has_many :balance_histories, dependent: :destroy

  accepts_nested_attributes_for :balance_histories, allow_destroy: true

  def balance_in(amount, source, options = {})
    options[:status] = :in
    self.current_mutation += amount
    BalanceHistory.build_history(self, amount, source, options)
    save
  end

  def balance_out(amount, source, options = {})
    options[:status] = :out

    if amount.to_f > 0.to_f
      if self.current_mutation.to_f < amount.to_f
        errors.add(:base, "You have insufficient balance (E-wallet)")
      else
        self.current_mutation -= amount
        BalanceHistory.build_history(self, amount, source, options)
        self.save
      end
    end

    return self
  end

  def self.update_balance(user)
    balance           = user.current_balance
    current_period    = balance&.period
    next_month_period = current_period&.next_month

    # To Do : Need to Fix when next_month_period and current_period is nil
    if (Date.today >= next_month_period) and (current_period != next_month_period)
      balance = user.balances.new(period: next_month_period, previous_mutation: balance.current_mutation)
      balance.save
    end

    balance.calculate
  end

  def calculate
    total = 0
    balance_histories.each do |history|
      total += history.amount if history[:status].eql?('in')
      total -= history.amount if history[:status].eql?('out')
    end

    self.current_mutation = previous_mutation + total
    self.save unless new_record?
  end

  def refund_balance(amount, source, description)
    balance_in(amount, source, { description: description })
  end
end
