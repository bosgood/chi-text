module Api
  module V1
    class SubscribersController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def show
        @subscribers = Subscriber.all
      end
    end
  end
end