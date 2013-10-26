sid = ENV['TWILIO_ACCOUNT_SID']
auth = ENV['TWILIO_AUTH_TOKEN']
TW = Twilio::REST::Client.new(sid, auth) unless sid.nil? or auth.nil?