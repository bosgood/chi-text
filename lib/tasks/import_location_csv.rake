namespace :db do
  task :import_location_csv, [:csv_path, :location_type] => :environment do |t, args|
    puts "processing data file: #{args.csv_path}"
    num_records = 0
    File.open(args.csv_path, 'r').each do |line|
      num_records = num_records + 1
      district, address, city, state, zip, website, location = line.split(',')
      loc = Location.new(
        :district => district,
        :address => address,
        :city => city,
        :state => state,
        :zip => zip,
        :website => website,
        :location => location
      )
      loc.calculate_lat_lon_from_location
      loc.save
    end
    puts "processed #{num_records} records."
  end
end