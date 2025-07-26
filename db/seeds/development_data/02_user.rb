# START FAKE USERS
cities = ["Jakarta", "Bandung", "Surabaya", "Makassar", "Jogjakarta", "Banten"]
phone_codes = ["081", "085", "089", "087"]
home_codes  = ["022", "021", "211"]

fake_users = []
15.times do |num|
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email      = "#{first_name.downcase.underscore}@gmail.com"

  data = {
            email: email, password: 'user1234', password_confirmation: 'user1234',
            user_profile_attributes: {
              full_name: "#{first_name} #{last_name}",
              nric: Faker::IDNumber.croatian_id,
              dob: Faker::Date.birthday(min_age: 18, max_age: 40),
              gender: ["man", "woman"].shuffle.first,
              marital_status: ["Single", "Married"].shuffle.first,
              company: Faker::Company.name,
              job: Faker::Job.title,
              country: Country.first,
              city: cities.shuffle.last,
              postcode: Faker::Number.number(digits: 5),
              address: Faker::Address.full_address,
              mobile_phone: "#{phone_codes.shuffle.first}#{Faker::Number.number(digits: 8)}",
              home_number: "#{home_codes}#{Faker::Number.number(digits: 7)}",
              facebook: Faker::Internet.username(specifier: 10),
              instagram: "@#{Faker::Internet.username(specifier: 5..10)}",
              linkedin: "",
            }
          }
  fake_users << data
end

fake_users.each do |params|
  user = User.find_or_initialize_by(email: params[:email])
  user.skip_generate_default_password = true
  user.assign_attributes(params)
  user.save
end
# END FAKE USERS

# Create User
user1 = User.find_or_initialize_by(email: 'heqi@gmail.com')
user2 = User.find_or_initialize_by(email: 'hyuka@gmail.com')

users = [
  {
    email: user1.email, password: 'user1234', password_confirmation: 'user1234',
    user_profile_attributes: {
      id: user1.user_profile&.id,
      full_name: 'Heqi Fatiha Putri',
      nric: '123476534265',
      dob: Time.zone.today-20.years,
      gender: 'woman',
      marital_status: "Single",
      company: "PT.ABCDEF",
      job: "Web Developer",
      country: Country.first,
      city: 'Bandung',
      postcode: '40281',
      address: 'Jl.Puri No.81',
      mobile_phone: '08938374899',
      home_number: '211-20292009',
      facebook: "",
      instagram: "",
      linkedin: "",
    }
  },
  {
    email: user2.email, password: 'user1234', password_confirmation: 'user1234',
    user_profile_attributes: {
      id: user2.user_profile&.id,
      full_name: 'Hyuka',
      nric: '123454638574',
      dob: Time.zone.today-21.years,
      gender: 'man',
      marital_status: "Single",
      company: "PT.ABCDEF",
      job: "Web Developer",
      country: Country.first,
      city: 'Bandung',
      postcode: '40543',
      address: 'Jl.Cemara No.22',
      mobile_phone: '081645375647',
      home_number: '211-20265748',
      facebook: "",
      instagram: "",
      linkedin: "",
    }
  }
]

users.each do |params|
  user = User.find_or_initialize_by(email: params[:email])
  user.skip_generate_default_password = true
  user.assign_attributes(params)
  user.save
end

puts "#{User.all.count} User Succesfully created "
puts '--------------------------------'
puts ''
