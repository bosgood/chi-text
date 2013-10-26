module Api
  module V1
    class MessagesController < ApplicationController
      #skip_before_filter  :verify_authenticity_token
      #protect_from_forgery with: :null_session
      include MessagesHelper

      def receive
        body = params[:Body]
        from = params[:From]
        return nil if body.nil? or from.nil?
        replier = get_reply_handler(get_message_keyword(body))
        message = replier.call(body, from)
        @sms_resp = send_message from, message
        render text: @sms_resp
      end
    end
  end
end