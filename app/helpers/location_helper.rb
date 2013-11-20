module LocationHelper
  #
  # Original author: almartin <alex.m.martineau@gmail.com>
  # Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  # Modified on 10/26/13 by Brad Osgood
  #

  # Gets the distance between 2 pairs of coordinates
  def distance(loc1, loc2)
    lat1 = loc1.latitude
    lat2 = loc2.latitude
    lon1 = loc1.longitude
    lon2 = loc2.longitude

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

  # Gets the closest resource to a point, given a list of other points
  def closest(origin, destinations)
    nearest_distance = -1
    nearest = nil

    # Brute force search for the closest location (!)
    destinations.each do |dest|
      distance = distance(origin, dest)

      # Is first location or found closer location
      if nearest.nil? or nearest_distance > distance
        nearest = dest
        nearest_distance = distance
      end
    end

    nearest
  end
end

# Simple latitude/longitude pair, can substitute a Location model
class Loc
  def self.from_pair(pair)
    Loc.new(pair[0], pair[1])
  end

  attr_reader :latitude, :longitude
  def initialize(lat, lon)
    @latitude = lat.to_f
    @longitude = lon.to_f
  end
end