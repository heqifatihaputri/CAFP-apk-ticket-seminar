# Create Country
countries = [
  {
    country_name: 'Indonesia',
    nationality_name: 'Indonesian'
  },
  {
    country_name: 'Malaysia',
    nationality_name: 'Malaysian'
  },
  {
    country_name: 'Singapore',
    nationality_name: 'Singaporean'
  },
  {
    country_name: 'Others',
    nationality_name: 'Others'
  }
]

countries.each do |params|
  country = Country.find_or_initialize_by(country_name: params[:country_name])
  country.assign_attributes(params)
  country.save
end

puts "#{Country.all.count} Country Succesfully created "
puts '--------------------------------'
puts ''