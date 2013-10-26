class MessagesController < ApplicationController
  def index
    puts TW.inspect
    puts params
  end
end
