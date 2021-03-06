require 'nokogiri'
require 'net/http'
require 'uri'


namespace :db do
  task :import_location_csv, [:csv_url, :location_type] => :environment do |t, args|
    import_location_csv(args.csv_url, args.location_type)
  end
  task :import_locations => :environment do
    import_list =
    [ ['https://data.cityofchicago.org/api/views/z8bn-74gv/rows.xml?accessType=DOWNLOAD', 'police_station'],
      ['https://data.cityofchicago.org/api/views/28km-gtjn/rows.xml?accessType=DOWNLOAD', 'fire_station'],
      ['https://data.cityofchicago.org/api/views/htai-wnw4/rows.xml?accessType=DOWNLOAD', 'city_office'],
      ['https://data.cityofchicago.org/api/views/x8fc-8rcq/rows.xml?accessType=DOWNLOAD', 'library'],
      ['https://data.cityofchicago.org/api/views/g5vx-5vqf/rows.xml?accessType=DOWNLOAD', 'flu_clinic']]

    import_list.each do |i|
      import_location_csv(i[0], i[1])
    end
    import_cta_train_data
  end
end

def import_cta_train_data
  CTA::TrainTracker.key = ENV['CTA_TRAIN_API_KEY']
  
  CTA::TrainTracker.stop_table.each do |stop|
    atrs = { latitude: stop["LAT"],
      longitude: stop["LON"],
      location_type: "CTA_Train",
      location: stop["STATION_NAME"]
    }
    if Location.find_by(atrs).nil?
      Location.create(atrs)
    end
  end
end

def import_location_csv csv_url, location_type
  puts "processing data file: #{csv_url}, type: #{location_type}"
  num_records = 0
  xml = Net::HTTP.get(URI.parse(csv_url))
  doc = Nokogiri::XML(xml)
  rows = doc.css('row > row')

  rows.each do |row|
    num_records = num_records + 1
    loc = nil
    case location_type
    when 'fire_station'
      loc = process_fire_station(row)
    when 'police_station'
      loc = process_police_station(row)
    when 'city_office'
      loc = process_city_office(row)
    when 'library'
      loc = process_library(row)
    when 'flu_clinic'
      loc = process_flu_clinic(row)
    end

    unless loc.nil?
      loc.merge!({
        :location_type => location_type
      })
      if Location.find_by(loc).nil?
        loc = Location.new(loc)
        puts "(#{loc.latitude}, #{loc.longitude})"
        loc.save
      end
    end
  end

  puts "processed #{num_records} records."
end

def process_flu_clinic(row)
  row = process_any(row)
  row
end

# <name>E119</name>
# <address>6030 N AVONDALE AVE</address>
# <city>CHICAGO</city>
# <state>IL</state>
# <zip>60631</zip>
# <engine>E119</engine>
# <location human_address="{"address":"6030 N AVONDALE AVE","city":"CHICAGO","state":"IL","zip":"60631"}" latitude="41.99120656361649" longitude="-87.79879483457952" needs_recoding="false"/>
def process_fire_station(row)
  row = process_any(row)
  # return row.merge({
  #   :location_type => 'fire_station'
  # })
  row
end

# <district>5</district>
# <address>727 E 111th St</address>
# <city>Chicago</city>
# <state>IL</state>
# <zip>60628</zip>
# <website url="https://portal.chicagopolice.org/portal/page/portal/ClearPath/Communities/Districts/District5"/>
# <location human_address="{"address":"727 111th St","city":"Chicago","state":"IL","zip":"60628"}" latitude="41.69279473591493" longitude="-87.60536435875626" needs_recoding="false"/>
def process_police_station(row)
  row = process_any(row)
  # return row.merge({
  #   :location_type => 'police_station'
  # })
  row
end

# <ward>1</ward>
# <alderman>JOE MORENO</alderman>
# <address>2058 N WESTERN AVE</address>
# <city>CHICAGO</city>
# <state>IL</state>
# <zipcode>60647</zipcode>
# <ward_phone phone_number="773-278-0101"/>
# <website url="http://www.cityofchicago.org/city/en/about/wards/01.html"/>
# <email>ward01@cityofchicago.org</email>
# <location human_address="{"address":"2058 WESTERN AVE","city":"CHICAGO","state":"IL","zip":"60647"}" latitude="41.91935384551596" longitude="-87.68747462738725" needs_recoding="false"/>
# <city_hall_address>121 N. La Salle Room 300, Office 5</city_hall_address>
# <city_hall_city>CHICAGO</city_hall_city>
# <city_hall_state>IL</city_hall_state>
# <city_hall_zipcode>60602</city_hall_zipcode>
# <city_hall_phone phone_number="312-744-3063"/>
def process_city_office(row)
  row = process_any(row)
  # return row.merge({
  #   :location_type => 'city_office'
  # })
  row
end
def process_library(row)
  process_any(row)
end

def process_any(row)
  location = row.css('location')
  lat = location.first[:latitude].to_f
  lon = location.first[:longitude].to_f
  return {
    :address => v(row, 'address'),
    :state => v(row, 'state'),
    :zip => v(row, 'zip'),
    :city => v(row, 'city'),
    :latitude => lat,
    :longitude => lon
  }
end

def v(row, sel)
  row.css(sel).inner_text
end