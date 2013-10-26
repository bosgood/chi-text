module MessagesHelper
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
