class MessagesController < ApplicationController
  include MessagesHelper
  
  def index
    binding.pry
    return nil if params[:Body].nil? or params[:From].nil?
    keyword = params[:Body].split(' ').first
    if keyword == 'directions'
      ds = DirectionsService.new
      match = params[:Body].match(/.*start\:(?<start>.+)end\:(?<end>.+)/)
      send_message ds.get_step_by_step_directions(match[:start], match[:end]).join('*')
    end
  end
  
  def send_message(body)
    MessageService.send_message(params[:From], body)
  end

end



=begin
Parameters: {"AccountSid"=>"AC11e679873f0a78342c14cba2d6250e70", "MessageSid"=>"SM8bc912b816bc6d25ae22983ad09383ee", "Body"=>"hey", "ToZip"=>"60603", "ToCity"=>"CHICAGO", "FromState"=>"IL", "ToState"=>"IL", "SmsSid"=>"SM8bc912b816bc6d25ae22983ad09383ee", "To"=>"+13126983244", "ToCountry"=>"US", "FromCountry"=>"US", "SmsMessageSid"=>"SM8bc912b816bc6d25ae22983ad09383ee", "ApiVersion"=>"2010-04-01", "FromCity"=>"TINLEY PARK", "SmsStatus"=>"received", "NumMedia"=>"0", "From"=>"+17086207839", "FromZip"=>"60428"}
=end
