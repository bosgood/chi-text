module Api
  module V1
    class MessagesController < ApplicationController
      #skip_before_filter  :verify_authenticity_token
      #protect_from_forgery with: :null_session
      include MessagesHelper

      def receive
        puts "[RECEIVED]: #{params.inspect}"
        body = params[:Body]
        from = params[:From]
        return nil if body.nil? or from.nil?

        msg = Message.new(body, from)
        replier = get_reply_handler(msg)
        message = replier.call(msg)
        @sms_resp = send_message from, message
        render text: @sms_resp.inspect
      end
    end
  end
end