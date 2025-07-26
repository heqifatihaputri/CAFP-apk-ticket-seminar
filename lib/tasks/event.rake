namespace :event do
  desc "Update ticket start selling"
  task update_ticket_start_selling: :environment do
    events = Event.event_opened.order(created_at: :DESC)

    events.each do |event|
      event.update(ticket_start_selling: false) if Time.zone.now >= event.end_time
    end
  end
end
