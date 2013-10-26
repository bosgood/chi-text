module LocationHelper
  #
  # Original author: almartin <alex.m.martineau@gmail.com>
  # Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  # Modified on 10/26/13 by Brad Osgood
  #
  def distance(lat1, lon1, lat2, lon2)
    earth_radius = 6371 # Earth's radius in KM

    def degrees_to_radians(value)
      unless value.nil? or value == 0
            value = (value/180) * Math::PI
      end
    return value
    end

    delta_lat = (lat2-lat1)
    delta_lon = (lon2-lon1)
    delta_lat = degrees_to_radians(delta_lat)
    delta_lon = degrees_to_radians(delta_lon)

    # Calculate square of half the chord length between latitude and longitude
    a = Math.sin(delta_lat/2) * Math.sin(delta_lat/2) +
        Math.cos((lat1/180 * Math::PI)) * Math.cos((lat2/180 * Math::PI)) *
        Math.sin(delta_lon/2) * Math.sin(delta_lon/2); 

    # Calculate the angular distance in radians
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    distance = earth_radius * c
    return distance
  end
end