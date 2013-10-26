class ClosestResourceService
  class << self
    include LocationHelper
    def closest_of_type(location_type, latitude, longitude)
      locations = Location.where(location_type: location_type)
      if locations.length == 0
        return nil
      end

      nearest = nil
      nearest_distance = -1
      
      # Brute force search for the closest location (!)
      locations.each do |loc|
        distance = distance(
          latitude.to_f, longitude.to_f, loc.latitude.to_f, loc.longitude.to_f
        )
        
        # Is first location or found closer location
        if nearest.nil? or nearest_distance > distance
          nearest = loc
          nearest_distance = distance
        end
      end
      
      nearest
    end
  end
end