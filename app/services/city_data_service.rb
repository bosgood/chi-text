require 'net/https'

class CityDataService
  CHICAGO_API_URL = 'https://data.cityofchicago.org/resource'
  class << self
    def make_data_request(resource)
      uri = URI("#{CHICAGO_API_URL}/#{resource}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      request = Net::HTTP::Get.new(uri.request_uri)
      request.add_field('X-App-Token', ENV['CITY_OF_CHICAGO_APP_TOKEN'])

      http.request(request)
    end

    def get_flu_shot_locations
      url = 'flu-shot-clinic-locations-2013.json'
      make_data_request(url)
    end
  end
end