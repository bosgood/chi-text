require 'google_directions'

class DirectionsService
  @@default_options = {
    :language => :en,
    :alternative => :true,
    :sensor => :false,
    :mode => :driving,
  }

  def initialize(options)
    @options = @@default_options.merge options
  end

  def language
    @options[:language]
  end

  def language=(lang)
    @options[:language] = lang
  end

  def directions_mode
    @options[:mode]
  end

  def directions_mode=(mode)
    @options[:mode] = mode
  end
  
  def directions_to(origin, destination)
    directions = GoogleDirections.new(origin, destination, @options)
    directions
  end

  def self.test
    ds = DirectionsService.new
    ds.directions_to(
      '300 W Adams St  Chicago, IL 60606',
      'W Merchandise Mart Plaza, Chicago IL 60654'
    )
  end
end