module Api
  module V1
    class MessagesController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      protect_from_forgery with: :null_session
      respond_to :json
      include MessagesHelper

      def receive
        body = params[:Body]
        return nil if body.nil? or params[:From].nil?
        replier = get_reply_handler(get_message_keyword(body))
        message = replier.call(body)
        @sms_resp = send_message params[:From], message
        @test = {
          :id => 12345
        }

        # render :json
        # respond_to do |format|
        #   format.json { render :json => {:id => 'asdf'} }
        # end
      end
    end
  end
end