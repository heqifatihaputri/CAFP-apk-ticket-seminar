event_1 = Event.find_by(name: "SEMINAR NASIONAL TL EXPO 2023")
event_2 = Event.find_by(name: "Creative Seminar C.L.I.C 2023 'Encapsulate Your Personage'")

event_sessions = [
  { 
    event: event_1,
    title: "SEMINAR NASIONAL TL EXPO 2023 - Session 1",
    status: :started,
    is_current: true,
  },
  { 
    event: event_1,
    title: "SEMINAR NASIONAL TL EXPO 2023 - Session 2",
    status: :not_started,
    is_current: false,
  },
  { 
    event: event_2,
    title: "Creative Seminar C.L.I.C 2023 - Session 1",
    status: :started,
    is_current: true,
  },
  { 
    event: event_2,
    title: "Creative Seminar C.L.I.C 2023 - Session 2",
    status: :not_started,
    is_current: false,
  },
]

event_sessions.each do |params|
event_session = EventSession.find_or_initialize_by(title: params[:title])
  event_session.assign_attributes(params)
  event_session.save
end

puts "#{EventSession.all.count} event_session Succesfully created "
puts '--------------------------------'
puts ''
