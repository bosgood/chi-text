class Location < ActiveRecord::Base
  attr_accessible :district, :address, :city, :state, :zip, :website, :location, :latitude, :longitude

  # Parses location string (e.g.: 3510 S Michigan Ave Chicago, IL 60653 (41.83086072588734, -87.62330200626332)") into latitude and longitude values
  def calculate_lat_lon_from_location
  end
end
