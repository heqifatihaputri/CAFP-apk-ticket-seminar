class BalanceHistory < ApplicationRecord
  belongs_to :balance
  belongs_to :source, polymorphic: true, optional: true

  enum status: [ :in, :out ]

  scope :by_range, -> (start_date, end_date) { where('trans_date BETWEEN (?) AND (?)', 
                                               start_date.in_time_zone.beginning_of_day, end_date.in_time_zone.end_of_day) }
  scope :by_periods, -> (user, date_start, date_end) { joins(:balance).where(balances: {user: user, period: date_start.beginning_of_month..date_end}) }
  scope :inflows,    -> { where(status: 'in') }  
  scope :outflows,   -> { where(status: 'out') }

  def self.build_history(balance, amount, source, options)
    source_id   = source.try(:id) || options[:source_id]
    source_type = source.try(:class).try(:name) || options[:source_type]

    options[:trans_date] ||= Date.today

    params_history = { amount: amount,
                       source_type: source_type,
                       source_id: source_id,
                       status: options[:status],
                       trans_date: options[:trans_date],
                       description: options[:description],
                       created_at: options[:created_at] }

    params_history  = params_history.merge(id: options[:id]) if options[:id].present?
    balance_history = balance.balance_histories.new(params_history)
  end

  def self.get_histories(user, date_start, date_end)
    return BalanceHistory.joins(:balance).where(balances: {user: user, period: date_start.beginning_of_month..date_end})
           .by_range(date_start, date_end)
  end
end
