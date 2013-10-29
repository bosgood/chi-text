bing_api_key = ENV['BING_MAPS_API_KEY']
Geocoder.configure( :lookup => :bing, api_key: bing_api_key ) unless bing_api_key.nil?