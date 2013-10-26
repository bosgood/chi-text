# Service for sending text messages through Twilio
class MessageService
  CHI_TEXT_NUMBER = '+13126983244'
  class << self
    def send_message(from, body)
      TW.account.messages.create({
        from: CHI_TEXT_NUMBER,
        to: from,
        body: body
      })
    end
  end
end