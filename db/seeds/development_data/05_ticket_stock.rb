admin = Admin.find_by(email: "admin@gmail.com")

event_1 = Event.find_by(name: "Go Scholarship 2023")
event_2 = Event.find_by(name: "SEMINAR NASIONAL TL EXPO 2023")

stocks = [
  {
    event: event_1,
    admin: admin,
    name: "Go Scholarship 2023 (early bird)",
    sku: "GS2023VRTEB",
    description: "Virtual Ticket",
    go_live: true,
    quantity: 100,
    price: 125000,
    start_sale: event_1.published_date.to_date,
    end_sale: event_1.start_time.to_date + 2.days,
    quantity: 100,
    total_stock: 100,
  },
  {
    event: event_1,
    admin: admin,
    name: "Go Scholarship 2023",
    sku: "GS2023VRT",
    description: "Virtual Ticket",
    go_live: true,
    quantity: 100,
    price: 150000,
    start_sale: event_1.published_date.to_date,
    end_sale: event_1.start_time.to_date + 2.days,
    quantity: 100,
    total_stock: 100,
  },
  {
    event: event_2,
    admin: admin,
    name: "SEMINAR NASIONAL TL EXPO 2023 (early bird)",
    sku: "SMEXPO2023PSYEB",
    description: "Physical Ticket",
    go_live: true,
    quantity: 100,
    price: 250000,
    start_sale: event_2.published_date.to_date,
    end_sale: event_2.start_time.to_date + 2.days,
    quantity: 100,
    total_stock: 100,
  },
  {
    event: event_2,
    admin: admin,
    name: "SEMINAR NASIONAL TL EXPO 2023",
    sku: "SMEXPO2023PSY",
    description: "Physical Ticket",
    go_live: true,
    quantity: 100,
    price: 300000,
    start_sale: event_2.published_date.to_date,
    end_sale: event_2.start_time.to_date + 2.days,
    quantity: 100,
    total_stock: 100,
  },
]

stocks.each do |params|
  ticket_stock = TicketStock.find_or_initialize_by(name: params[:name])
  ticket_stock.assign_attributes(params)
  ticket_stock.save
end

puts "#{TicketStock.all.count} ticket_stock Succesfully created "
puts '--------------------------------'
puts ''
