# Create Admin
admins = [
  {
    email: 'admin@gmail.com', name: 'Admin 1', password: 'admin1234', password_confirmation: 'admin1234'
  },
  {
    email: 'admin2@gmail.com', name: 'Admin 2', password: 'admin1234', password_confirmation: 'admin1234'
  }
]

admins.each do |params|
  country = Admin.find_or_initialize_by(email: params[:email])
  country.assign_attributes(params)
  country.save
end

puts "#{Admin.all.count} Admin Succesfully created "
puts '--------------------------------'
puts ''