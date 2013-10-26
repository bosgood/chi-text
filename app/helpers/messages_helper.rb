module MessagesHelper

  def paginate_message body
    return [body] if body.length <= 160
    messages = []
    i = 1
    len = 150
    num_messages = body.length / len
    0.upto num_messages do |i|
      messages.push("(#{i + 1}/#{num_messages + 1})" + body[(i * len)...((i + 1) * len)])
    end
    messages
  end
end
