module Api
  module V1
    class MessagesController < ApplicationController
      #skip_before_filter  :verify_authenticity_token
      #protect_from_forgery with: :null_session
      include ReplyHelper

      def receive
        puts "[RECEIVED]: #{params.inspect}"

        from = params[:From]

        # Nothing we can really do to reply to a message w/o their number
        return nil if from.nil?

        message = reply_to(params)
        if message.nil?
          # TODO convert message into an "invalid message" response
          message = ''
        end

        @sms_resp = send_message from, message
        render text: @sms_resp.inspect
      end
    end
  end
end