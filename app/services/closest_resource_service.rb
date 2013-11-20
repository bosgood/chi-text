class ClosestResourceService
  class << self
    include LocationHelper
    def closest_of_type(location_type, latitude, longitude)
      locations = Location.where(location_type: location_type)
      if locations.length == 0
        return nil
      end

      closest(Loc.new(latitude, longitude), locations)
    end

    def get_lat_lon_from_address(address)
      Geocoder.coordinates address
    end
  end
end