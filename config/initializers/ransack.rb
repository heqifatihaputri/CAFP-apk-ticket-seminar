Ransack.configure do |config|
  config.add_predicate 'between',
    arel_predicate: 'between',
    formatter: proc { |v|
      parts = v.split(' - ')
      OpenStruct.new(begin: parts[0].to_date.beginning_of_day, end: parts[1].to_date.end_of_day)
    },
    validator: proc { |v| v.present? },
    type: :string

  config.add_predicate 'date_equals',
    :arel_predicate => 'eq',
    :formatter => proc {|v| v.to_date.to_s(:db) },
    :validator => proc {|v| v.present?},
    :compounds => true,
    :type => :date
end