module MessagesHelper
  class Message
    include LanguageHelper
    def initialize(body, from)
      @body = body
      @params = get_message_params(body)
      @from = from
    end

    def body
      @body
    end

    def language
      @params[:language]
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

    def get_lang_pair(raw_keyword)
      t_(raw_keyword) 
    end

    # Parses a text message to get a keyword and "rest"
    def get_message_params(body)
      delim = ' '
      tokens = body.split(delim)
      token = tokens.first 
      token = '' if token.nil?
      lang_pair = get_lang_pair(token.downcase) 
      keyword = lang_pair[:operation]
      tokens = tokens[1..-1]
      tokens = [] if tokens.nil?
      return {
        :keyword => keyword,
        :rest => tokens.join(delim),
        :tokens => tokens,
        :language => lang_pair[:language]
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

  def get_reply_handler(msg)
    m = "get_reply_for_" + msg.keyword.to_s
    if respond_to?(m)
      return method(m)
    else
      return method("get_reply_for_undefined")
    end
  end

  #
  # Message handlers are defined here as "get_reply_for_#{keyword}"
  #

  def closest_location(location_type, msg)
    loc = msg.location
    if loc.nil?
      return nil
    end
    ClosestResourceService.closest_of_type(
      location_type, loc[0], loc[1]
    )
  end

  def get_reply_for_directions(msg)
    match = msg.body.match(/.*start(?<start>.+)end(?<end>.+)/)
    if match.nil?
      return t(msg.language, 'invalidAddress', {})
    end

    ds = DirectionsService.new
    ds.get_step_by_step_directions(match[:start], match[:end]).join(' * ')
  end

  def get_reply_for_flu(msg)
    closest_loc = closest_location(:flu_clinic, msg)
    if closest_loc.nil?
      return nil
    else
      return t(
        msg.language,
        'fluData',
        { nearSavedAddress: closest_loc.address }
      )
    end
  end

  def get_reply_for_fire(msg)
    closest_loc = closest_location(:fire_station, msg)
    if closest_loc.nil?
      return nil
    else
      return t(
        msg.language,
        'fireData',
        { fireNearSavedAddress: closest_loc.address }
      )
    end
  end

  def get_reply_for_police(msg)
    closest_loc = closest_location(:police_station, msg)
    if closest_loc.nil?
      return nil
    else
      # TODO: need phone data
      # phone = closest_loc.phone
      return t(msg.language, "policeData", { stationAddress: closest_loc.address })
    end
  end

  def get_reply_for_help(msg)
    t(msg.language, 'features', {})
  end

  def get_reply_for_welcome(msg)
    t(msg.language, 'welcome', {})
  end

  def get_reply_for_undefined(msg)
    t(msg.language, 'unrecognizedInput', {})
  end

  def t(lang, key, params)
    I18n.locale = lang
    Mustache.render(I18n.t(key), params)
    I18n.locale = 'en'
  end

  # def get_reply_for_plow(msg)
  # end
end
