seed_files = Dir.glob("#{Rails.root}/db/seeds/default_data/*.rb").sort

seed_files.each do |seed_file|
  if File.exists?(seed_file)
    seed_name = seed_file.split("/").last.gsub(".rb", "").titleize
    puts "==> Loading #{seed_name} data"
    require seed_file
    puts "==> #{seed_name} data Loaded"
  end
end
