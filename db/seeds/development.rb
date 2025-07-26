# IMPORT ADMIN
puts "==> Importing Admin data"
admins = Dir.glob("#{Rails.root}/db/seeds/development_data/01_admin.rb").last
require admins if File.exists?(admins)

# IMPORT USER
puts "==> Importing User data"
users = Dir.glob("#{Rails.root}/db/seeds/development_data/02_user.rb").last
require users if File.exists?(users)

# IMPORT Venue
puts "==> Importing Venue data"
venues = Dir.glob("#{Rails.root}/db/seeds/development_data/03_venue.rb").last
require venues if File.exists?(venues)

# IMPORT Event
puts "==> Importing Event data"
events = Dir.glob("#{Rails.root}/db/seeds/development_data/04_event.rb").last
require events if File.exists?(events)

# IMPORT TicketStock
puts "==> Importing Event data"
stocks = Dir.glob("#{Rails.root}/db/seeds/development_data/05_ticket_stock.rb").last
require stocks if File.exists?(stocks)

# IMPORT EventSession
puts "==> Importing EventSession data"
event_sessions = Dir.glob("#{Rails.root}/db/seeds/development_data/06_event_session.rb").last
require event_sessions if File.exists?(event_sessions)
