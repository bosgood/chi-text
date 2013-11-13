module Api
  module V1
    class TestController < ApplicationController
      include ReplyHelper

      def receive
        puts "[RECEIVED]: #{params.inspect}"
        resp = reply_to(params)
        displayed = "Message: #{resp}\nLength: #{resp.length}"
        render text: displayed
      end
    end
  end
end