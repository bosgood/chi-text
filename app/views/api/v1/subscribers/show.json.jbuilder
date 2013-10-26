Jbuilder.encode do |json|
  json.array! @subscribers do |subscriber|
    json.phone_number subscriber.phone_number
    json.address subscriber.address
    json.language subscriber.language
  end
end