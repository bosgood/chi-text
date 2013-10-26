module MessagesHelper
  class Message
    def initialize(body, from)
      @body = body
      @params = get_message_params(body)
      @from = from
    end

    def body
      @body
    end

    def keyword
      @params[:keyword]
    end

    def rest
      @params[:rest]
    end

    def tokens
      @params[:tokens]
    end

    def location
      stored_loc = get_current_location(@from)

      unless stored_loc.nil?
        return stored_loc
      end

      # No location on file, attempt to parse "rest" as their address
      ClosestResourceService.get_lat_lon_from_address(rest)
    end

    protected

    # Helper method to get the location from their subscriber info
    def get_current_location(from)
      subscriber = Subscriber.where(:phone_number => from).take
      return nil if subscriber.nil?
      return subscriber.address
    end

    # Parses a text message to get a keyword and "rest"
    def get_message_params(body)
      delim = ' '
      tokens = body.split(delim)
      keyword = tokens.pop
      # TODO translation here, turn into command keyword
      return {
        :keyword => keyword,
        :rest => tokens.join(delim),
        :tokens => tokens
      }
    end
  end

  def paginate_message(body)
    return [body] if body.length <= 160
    messages = []
    len = 150
    num_messages = body.length / len
    0.upto num_messages do |i|
      messages.push("(#{i + 1}/#{num_messages + 1})" + body[(i * len)...((i + 1) * len)])
    end
    messages
  end

  def send_message(from, body)
    MessageService.send_message(from, body)
  end

  def get_message_keyword(body)
    keyword = body.split(' ').first
    # TODO translation here, turn into command keyword
    keyword
  end

  def get_reply_handler(keyword)
    m = "get_reply_for_" + keyword
    if respond_to?(m)
      return method(m)
    else
      return nil
    end
  end

  #
  # Message handlers are defined here as "get_reply_for_#{keyword}"
  #

  def get_reply_for_directions(body)
    match = body.match(/.*start\:(?<start>.+)end\:(?<end>.+)/)
    ds = DirectionsService.new
    ds.get_step_by_step_directions(match[:start], match[:end]).join(' * ')
  end


  def get_reply_for_plow
  end
end
