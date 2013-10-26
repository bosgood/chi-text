require 'google_directions'

class DirectionsService
  @@default_options = {
    :language => :en,
    :alternative => :true,
    :sensor => :false,
    :mode => :driving,
    :region => :us
  }


  def initialize(options = {})
    @options = @@default_options.merge options
    @sanitizer = HTML::FullSanitizer.new
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
  
  def get_directions(origin, destination)
    directions = GoogleDirections.new(origin, destination, @options)
    directions
  end

  def get_step_by_step_directions(origin, destination)
    directions = get_directions(origin, destination)
    directions_xml = directions.doc
    instructions = directions_xml.css('step html_instructions').map do |instr|
      @sanitizer.sanitize(CGI::unescapeHTML(instr.children[0].to_s))
    end
    instructions
  end

  def self.test(options = {})
    ds = DirectionsService.new(options)
    directions = ds.get_step_by_step_directions(
      '300 W Adams St Chicago, IL 60606',
      'W Merchandise Mart Plaza, Chicago IL 60654'
    )
    turn_by_turn = directions.join('. ')
    puts turn_by_turn
  end
end