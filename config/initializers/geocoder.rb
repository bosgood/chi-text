
api_key = ENV['GOOGLE_API_KEY']
unless api_key.nil?
  Geocoder.configure( :api_key => api_key)
end