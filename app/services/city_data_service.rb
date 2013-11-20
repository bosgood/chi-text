require 'net/https'

class CityDataService
  CHICAGO_API_URL = 'https://data.cityofchicago.org/resource/'

  def make_data_request(resource, params)
    uri = URI("#{CHICAGO_API_URL}/#{resource}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field('X-App-Token', ARGV[0])

    http.request(request)
  end

  def get_flu_shot_locations
    url = 'flu-shot-clinic-locations-2013.json?recall_id=94'
    make_data_request(url)
  end
end