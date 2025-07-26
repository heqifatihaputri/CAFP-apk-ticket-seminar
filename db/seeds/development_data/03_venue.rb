country = Country.find_by(country_name: "Indonesia")

venues = [
  {
    name: "Sofyan Hotel Soepomo",
    city: "Jakarta",
    state: "Indonesia",
    postcode: "12810",
    contact: "08111492323",
    full_address: "Jalan Dr. Soepomo, SH No. 23, Tebet, Jakarta, Indonesia, 12810",
    country: country,
  },
  {
    name: "Grand Ballroom Balai Kartini",
    city: "Jakarta",
    state: "Indonesia",
    postcode: "12950",
    contact: "085647362545",
    full_address: "Jl. Gatot Subroto No.Kav. 37, RT.6/RW.3, Kuningan, Kuningan Tim, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12950",
    country: country,
  },
  {
    name: "Sunda Space",
    city: "Bandung",
    state: "Indonesia",
    postcode: "40276",
    contact: "081289004848",
    full_address: "Jalan Sunda no 85 kel Kb Pisang Kec Sumur Bandung Kota Bandung, Sunda Space Meeting Room Lantai 1",
    country: country,
  },
  {
    name: "Villa Bukit Pinus",
    city: "Bandung",
    state: "Indonesia",
    postcode: "40968",
    contact: "0251-8242047",
    full_address: "Jalan Ciderum - Pancawati, Pancawati, Kec. Caringin, Kabupaten Bogor, Jawa Barat 40115",
    country: country,
  },
  {
    name: "Ruang Hijau Space",
    city: "Tanggerang Selatan",
    state: "Indonesia",
    postcode: "15326",
    contact: "081289004848",
    full_address: "H.RISIN 3RH, Pd. Jagung Tim., Kec. Serpong Utara, Kota Tangerang Selatan, Banten 15326, dekat dengan mall living world alam sutera dan mall alam sutera",
    country: country,
  },
  {
    name: "The Kasablanka",
    city: "Jakarta",
    state: "Indonesia",
    postcode: "12870",
    contact: "021-7483738",
    full_address: " lantai 3 Mall Kota Kasablanka, Jl. Casablanca Raya kav. 88, RT.3/RW.14, Menteng Dalam, Kec. Tebet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12870.",
    country: country,
  },
  {
    name: "Villa MS Bandung",
    city: "Bandung",
    state: "Indonesia",
    postcode: "40143",
    contact: "08118383662",
    full_address: "Komplek Bukit Idaman, Jl. Cipaku Indah X, Ciumbuleuit, Cidadap, Bandung City, West Java 40143",
    country: country,
  },
]

venues.each do |params|
  venue = Venue.find_or_initialize_by(name: params[:name])
  venue.assign_attributes(params)
  venue.save
end

puts "#{Venue.all.count} venue Succesfully created "
puts '--------------------------------'
puts ''
