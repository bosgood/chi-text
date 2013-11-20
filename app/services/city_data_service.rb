require 'net/https'

class APIError < Exception
  attr_reader :message, :uri, :resp

  def initialize(message, uri, resp)
    @uri = uri
    @resp = resp
    @message = message
  end
end

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

      resp = http.request(request)
      if resp.code.to_i != 200
        raise APIError.new('unable to load chicago data', uri, resp)
      end

      return JSON.load(resp.body)
    end

    # Individual API accessors
    # Example data:
    # [{"street1"=>"11207 S. Ewing",
    #   "phone"=>"(773) 721-1999",
    #   "facility_name"=>"10th Ward-Knights of Columbus",
    #   "begin_time"=>"9am",
    #   "end_time"=>"3pm",
    #   "postal_code"=>"60617",
    #   "state"=>"IL",
    #   "facility_type"=>"Alderman",
    #   "begin_date"=>"2013-10-25T00:00:00",
    #   "longitude"=>"-87.5351333203",
    #   "latitude"=>"41.6915835405",
    #   "city"=>"Chicago"}, ... ]
    def get_flu_shot_locations
      make_data_request('flu-shot-clinic-locations-2013.json')
    end
  end
end