# Module to abstract processing and replying with a message
module ReplyHelper
  include MessagesHelper

  # Expects params to be a hash with Body and From params defined
  def reply_to(params)
    body = params[:Body]
    from = params[:From]
    return nil if body.nil?

    msg = Message.new(body, from)
    replier = get_reply_handler(msg)
    return replier.call(msg)
  end
end