# zoom = Venue.find_by(name: "Zoom")

events = [
  {
    # https://eventkampus.com/event/detail/4414/go-scholarship-2023
    name: "Go Scholarship 2023",
    description: "<p>🎓𝐎𝐩𝐞𝐧 𝐑𝐞𝐠𝐢𝐬𝐭𝐫𝐚𝐭𝐢𝐨𝐧 𝐆𝐨 𝐒𝐜𝐡𝐨𝐥𝐚𝐫𝐬𝐡𝐢𝐩 𝟐𝟎𝟐𝟐🎓</p><p><br></p><p>Go Scholarship 2023 proudly present</p><p>“𝙀𝙣𝙧𝙞𝙘𝙝 𝙮𝙤𝙪𝙧 𝘼𝙗𝙞𝙡𝙞𝙩𝙮, 𝙐𝙣𝙡𝙤𝙘𝙠 𝙮𝙤𝙪𝙧 𝙣𝙚𝙬 𝙊𝙥𝙥𝙤𝙧𝙩𝙪𝙣𝙞𝙩𝙮”</p><p>An Inspiring with our awardees from several well-known scholarships and “𝐏𝐚𝐫𝐚𝐦𝐚 𝐏𝐫𝐚𝐝𝐚𝐧𝐚 𝐒𝐮𝐭𝐞𝐣𝐚” as our guest star!</p><p><br></p><p>Event will be held on:</p><p>📅 : #{(Date.today+1.week).in_time_zone.to_date}</p><p>⏰ : 09.00 WIB</p><p>📍 : Zoom Meeting</p><p><br></p><p>𝐅𝐑𝐄𝐄 𝐑𝐄𝐆𝐈𝐒𝐓𝐑𝐀𝐓𝐈𝐎𝐍&nbsp;❗</p><p>𝐓𝐡𝐢𝐬 𝐞𝐯𝐞𝐧𝐭 𝐢𝐬 𝐨𝐩𝐞𝐧 𝐟𝐨𝐫 𝐩𝐮𝐛𝐥𝐢𝐜.</p><p><br></p><p>So, what are you waiting for? It's free!</p><p>Register now and start to level up your education ✨</p><p>https://linktr.ee/goscholarship2023</p><p><br></p><p><br></p><p>✨𝗙𝗼𝗿 𝗳𝘂𝘁𝗵𝗲𝗿 𝗶𝗻𝗳𝗼𝗿𝗺𝗮𝘁𝗶𝗼𝗻, 𝗰𝗵𝗲𝗰𝗸 𝗼𝘂𝗿 𝗦𝗼𝗰𝗶𝗮𝗹 𝗠𝗲𝗱𝗶𝗮 𝗮𝗻𝗱 𝗖𝗼𝗻𝘁𝗮𝗰𝘁 𝗣𝗲𝗿𝘀𝗼𝗻 𝗯𝗲𝗹𝗼𝘄 ✨:</p><p>Instagram: @Goscholarship2023</p><p>LinkedIn: Go Scholarship2023</p><p>TikTok: @Go_Scholarship</p><p><br></p><p>𝐂𝐨𝐧𝐭𝐚𝐜𝐭 𝐏𝐞𝐫𝐬𝐨𝐧 :&nbsp;</p><p>Ivana : 082214973852 (WA)</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adhila_nasywaa (LINE)</p><p>Erfina : 081907120457 (WA)</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;finaabfdl (LINE)</p><p><br></p><p>______</p><p>Departemen Adkesma</p><p><br></p><p><br></p><p><br></p><p>#GoScholarship2023</p><p>#KabinetSinergiCita</p><p>#BEMFEBUNAIR2023</p><p>#FEBSatu</p><p>#UNAIRHEBAT</p>",
    start_time: "#{(Date.today+1.week).in_time_zone.to_date} 09:00AM WIB".to_datetime,
    end_time: "#{(Date.today+1.week).in_time_zone.to_date} 08:00PM WIB".to_datetime,
    ticket_start_selling: true,
    speaker: "Parama Pradana Suteja, Lisna Giacina, M.Raihan Athalariq R, Meilia Choirun Nisa, Yanisa Asrika Tinaldi.",
    published_date: "#{(Date.today-1.week).in_time_zone.to_date} 08:00 PM WIB".to_datetime,
    venue: Venue.find_by(name: "Sofyan Hotel Soepomo"),
  },
  {
    # https://eventkampus.com/event/detail/4395/seminar-nasional-tl-expo-2023
    name: "SEMINAR NASIONAL TL EXPO 2023",
    description: "<p>SEMINAR NASIONAL TL EXPO 2023</p><p><br></p><p>Jangan lewatkan Seminar Nasional “Environment Restoration to Reach SDGs With Action”. Dapatkan kesempatan untuk mendalami topik dari narasumber yang kompeten di bidangnya.</p><p><br></p><p>Save the Date ⚠️</p><p>🗓 #{(Date.today+2.week).in_time_zone.to_date}</p><p>⏰ 07.30 - Selesai</p><p>📍 Engineering Hall Dekanat Fakultas Teknik Universitas Diponegoro, Jl. Prof Sudarto, Tembalang, Semarang, Jawa Tengah, 50275.</p><p><br></p><p>Speakers 🎙️</p><p>1.  Ir. Sigit Reliantoro, M.Sc ( Direktur Jenderal Pengendalian Pencemaran dan Kerusakan Lingkungan KLHK )</p><p>2. Sripeni Inten Cahyani ( Tenaga Ahli Menteri Energi Bersih dan Mineral )</p><p>3. Ir. Priyadi ( Presiden Direktur, PT Adaro Indonesia )</p><p>4.  Prof. Dr.rer.nat. Imam Buchori, ST ( Guru Besar Perencanaan Wilayah dan Kota, Fakultas Teknik Universitas Diponegoro )</p><p><br></p><p><br></p><p>Benefits ✨</p><p>✔️ Sertifikat</p><p>✔️ Knowledge</p><p>✔️ Snack</p><p>✔️ Lunch</p><p>✔️ Seminar kit</p><p>✔️ Photobooth</p><p>✔️ Doorprize</p><p><br></p><p>Price 💵</p><p>Early Bird Ticket&nbsp;: SOLD</p><p>Pre Sale 1 Ticket&nbsp;: SOLD OUT</p><p>Pre Sale 2 Ticket : SOLD OUT</p><p>Normal : Rp50.000,00&nbsp;</p><p><br></p><p>⚠️ please fill all question on the registration form with the right information. For more information, please check our official instagram @tl_expo or contact our personal contact ⚠️</p><p><br></p><p>Link Registrasi 🖇</p><p>bit.ly/RegistrasiSemNasTLExpo2023</p><p><br></p><p><br></p><p>Payment 💸</p><p>Rekening yang dituju tertera pada link registrasi. Kirimkan bukti pembayaran kepada CP dengan format :&nbsp;</p><p>MetodePembayaran_Nama_Tanggal. Contoh : Mandiri_Helga Fawwas_28 Agustus</p><p><br></p><p>Contact Person 📞</p><p>📲 085771420564 (Husnul Karimah)</p><p>📲 0895401534743 (Zulfikar Imampuro)</p>",
    start_time: "#{(Date.today+2.week).in_time_zone.to_date} 07:30 AM WIB".to_datetime,
    end_time: "#{(Date.today+2.week+1.day).in_time_zone.to_date} 03:00 PM WIB".to_datetime,
    ticket_start_selling: true,
    speaker: "Ir. Sigit Reliantoro, M.Sc, Sripeni Inten Cahyani, Ir. Priyadi, Prof. Dr.rer.nat. Imam Buchori, ST. ",
    published_date: "#{(Date.today-1.week).in_time_zone.to_date} 08:00 PM WIB".to_datetime,
    venue: Venue.find_by(name: "Grand Ballroom Balai Kartini"),
  },
  {
    # https://eventkampus.com/event/detail/4385/pekan-raya-biologi-2023#!
    name: "Pekan Raya Biologi 2023",
    description: "<p>📣 Pekan Raya Biologi 2023 Present 📣</p><p><br></p><p>Bedah Buku&nbsp;&amp; Seminar Nasional sebagai Acara Puncak Pekan Raya Biologi 2023.</p><p><br></p><p>📌Bedah Buku 'You Do You: Discovering Life Through Experiment &amp; Self Awareness'</p><p>Narasumber: Hestia Istiviani (Business Development Manager &amp; Inisiator of Baca Bareng)</p><p>Moderator: Rusydan Latifah (Ketua UKM Exact 2023)</p><p><br></p><p>Save The Date!</p><p>📅: #{(Date.today+3.week).in_time_zone.to_date}</p><p>🕖: 08.00 - Selesai</p><p>📍: Zoom Meeting &amp; Teatrikal Lt.1 FST</p><p><br></p><p>Link Pendaftaran:</p><p>bit.ly/DaftarBedahBuku2023</p><p><br></p><p>📌Seminar Nasional 'Aktualisasi dan Tantangan Perkembangan Bioteknologi Dalam Membangun Masyarakat Modern'</p><p>Narasumber:</p><p>1. Prof. Dr. Endang Semiarti, M.S., M.Sc. (Guru Besar Ilmu Kultur Jaringan Tumbuhan &amp; Bioteknologi Tumbuhan UGM)</p><p>2. Jumailatus Sholihah S.Si., M.Si. (Halal Center UIN Sunan Kalijaga Yogyakarta)</p><p>3. Dr. Ema Damayanti, M.Biotech (Periset BRIN Gunungkidul)</p><p>Moderator: Ika Nugraheni Ari Martiwi, M.Si. (Dosen Biologi UIN Sunan Kalijaga)</p><p><br></p><p>Save The Date!</p><p>📅: #{(Date.today+3.week+1.day).in_time_zone.to_date}</p><p>🕖: 07.30 - Selesai</p><p>📍: Zoom Meeting &amp; Teatrikal Lt. 1 FST</p><p><br></p><p>Link Pendaftaran:</p><p>bit.ly/DaftarSemnas2023</p><p><br></p><p>Diselingi penampilan dari Saintek Musik dan FREE HTM‼️ Jangan Sampai Terlewat💯</p><p><br></p><p>More Information:</p><p>Amanda (081294367663)</p><p>Rosita (088215791367)</p><p>@prbuinsuka2023</p><p><br></p><p>#prbuinsuka2023 #seminar #webinar #bedahbuku #seminaronline #webinaronline #seminarnasional #webinarnasional #seminargratis #webinargratis #eventpelajar #eventmahasiswa #event #mahasiswa #pelajar #sma #uin #uinsuka #yogyakarta #biologi #bioteknologi #jawatengah #jawabarat #jawatimur #jakarta</p>",
    start_time: "#{(Date.today+3.week).in_time_zone.to_date} 08:00 AM WIB".to_datetime,
    end_time: "#{(Date.today+3.week+1.day).in_time_zone.to_date} 12:00 PM WIB".to_datetime,
    ticket_start_selling: true,
    speaker: "Prof. Dr. Endang Semiarti, M.S., M.Sc, Jumailatus Sholihah S.Si., M.Si, Dr. Ema Damayanti, M.Biotech.",
    published_date: "#{(Date.today-1.week).in_time_zone.to_date} 08:00 PM WIB".to_datetime,
    venue: Venue.find_by(name: "Sofyan Hotel Soepomo"),
  },
  {
    # https://eventkampus.com/event/detail/4405/the-7th-annual-international-conference-and-exhibition-on-indonesian-medical-education-and-research-institute#!
    name: "The 7th Annual International Conference and Exhibition on Indonesian Medical Education and Research Institute",
    description: "<p>The 7th Annual International Conference and Exhibition on Indonesian Medical Education and Research Institute</p><p>”Welcome Back to The Future of Biomedical Science”</p><p><br></p><p>⚠️OPEN REGISTRATION NOW⚠️</p><p>17 CONCURRENT SESSIONS and 13 WORKSHOPS</p><p>With “National &amp; International Speaker”</p><p><br></p><p>📌Concurrent Session : #{(Date.today+1.month+1.day).in_time_zone.to_date}</p><p>📌 Workshops : #{(Date.today+1.month).in_time_zone.to_date}</p><p>Registration Symposium : FREE!!</p><p>SKP IDI ACCREDITED!</p><p><br></p><p>REGISTER NOW THROUGH:</p><p>https://iceonimeri.id/participant/register&nbsp;</p><p><br></p><p>For More Information:</p><p>Website: www.iceonimeri.id</p><p>Instagram: @iceonimeri</p><p>Email: imeri-ic@ui.ac.id</p><p><br></p><p>#medicine #imeri #fkui #ui #iceonimeri #workshop #symposium #event</p>",
    start_time: "#{(Date.today+1.month).in_time_zone.to_date} 08:00 AM WIB".to_datetime,
    end_time: "#{(Date.today+1.month+1.day).in_time_zone.to_date} 04:00 PM WIB".to_datetime,
    ticket_start_selling: true,
    speaker: "Harald T.Jostrad, Sam El Osta, Mohammad Ilyas",
    published_date: "#{(Date.today-1.week).in_time_zone.to_date} 08:00 PM WIB".to_datetime,
    venue: Venue.find_by(name: "Ruang Hijau Space"),
  },
  {
    # https://eventkampus.com/event/detail/4318/pasarind-talks-pentingnya-customer-retention-untuk-bisnis
    name: "Pasarind Talks 'Pentingnya Customer Retention Untuk Bisnis'",
    description: "<p>Sebagian besar pebisnis terkadang hanya memfokuskan perhatian pada strategi memperoleh konsumen baru. Padahal, mempertahankan konsumen lama untuk tetap menggunakan produk yang kita jual merupakan hal yang tidak kalah penting!</p><p><br></p><p>Dengan menerapkan strategi customer retention, diharapkan mampu memperkuat koneksi konsumen dengan pelanggan. Lalu, mengapa customer retention itu begitu penting untuk bisnis?</p><p>Simak tipsnya di webinar Pasarind POS bersama Yunita Valentina CRM Manager CT Corp Digital.</p><p><br></p><p>Catat tanggalnya, ya!</p><p>📆 #{Date.today.in_time_zone.to_date}</p><p>⏰ 15.00-18.00 WIB</p><p><br></p><p>Dapatkan berbagai hadiah menarik TOTAL 3 juta rupiah. Acara ini GRATIS &amp; Registrasi sekarang klik link di BIO atau daftar di bayarind.co/PasarindTalksEps5</p><p><br></p><p>#eventkampus #talkshow #customerRetention #talkshowbisnis</p>",
    start_time: "#{Date.today.in_time_zone.to_date} 03:00 PM WIB".to_datetime,
    end_time: "#{Date.today.in_time_zone.to_date} 06:00 PM WIB".to_datetime,
    ticket_start_selling: true,
    speaker: "Yunita Valentina",
    published_date: "#{(Date.today-1.week).in_time_zone.to_date} 08:00 PM WIB".to_datetime,
    venue: Venue.find_by(name: "The Kasablanka"),
  },
  {
    name: "Creative Seminar C.L.I.C 2023 'Encapsulate Your Personage'",
    description: "<p>💫Creative seminar C.L.I.C 2023 “Encapsulate Your Personage”💫.&nbsp;</p><p>Disini kita akan sama-sama mengupas bagaimana cara menerima serta mengembangkan diri untuk menjadi versi terbaik dari diri kamu lohh 😱✨.&nbsp;&nbsp;</p><p><br></p><p>Our Speakers:&nbsp;</p><p>💁🏻&zwj;♀️ Cinta Laura (Actress, Singer, and Model)&nbsp;</p><p>💁🏻&zwj;♀️ Sonia Basil (CEO of Cakelogy and Keku)&nbsp;&nbsp;</p><p><br></p><p>MARK THE DATE!&nbsp;</p><p>🗓 #{(Date.today+1.day).in_time_zone.to_date}</p><p>⏰ 19:00 WIB – Selesai&nbsp;</p><p>📌 Zoom Meeting&nbsp;&nbsp;</p><p><br></p><p>FREE E-CERTIFICATE&nbsp;&nbsp;</p><p><br></p><p>‼️Registration periode: 31 May-9 June 2023‼️&nbsp;&nbsp;</p><p>Yuk segera daftar di: https://bit.ly/RegistrationSeminar1CLIC&nbsp;&nbsp;</p><p><br></p><p>LIMITED SLOT, JANGAN SAMPAI KEHABISAN YA TEMAN-TEMAN😱❗️&nbsp;&nbsp;</p><p><br></p><p>For more information:&nbsp;</p><p>- LINE OA: @clicprasmul&nbsp;</p><p>- WhatsApp: 081932512956 (Jessica)&nbsp;&nbsp;&nbsp;</p><p><br></p><p>SEE YOU ON CREATIVE SEMINAR C.L.I.C 👋🏻♥️</p><p><br></p><p>#eventkampus #seminar #webinar</p>",
    start_time: "#{(Date.today+1.day).in_time_zone.to_date} 07:00 PM WIB".to_datetime,
    end_time: "#{(Date.today+1.day).in_time_zone.to_date} 08:30 PM WIB".to_datetime,
    ticket_start_selling: true,
    speaker: "Cinta Laura Kiehl, Sonia Basil",
    published_date: "#{(Date.today-1.week).in_time_zone.to_date} 08:00 PM WIB".to_datetime,
    venue: Venue.find_by(name: "Villa MS Bandung"),
  },
]

events.each do |params|
  event = Event.find_or_initialize_by(name: params[:name])
  event.assign_attributes(params)
  event.save
end

puts "#{Event.all.count} event Succesfully created "
puts '--------------------------------'
puts ''
