FactoryBot.define do
  factory :phone do
    # Note -- we're being very strict with our phone numbers    
    phone_number "#{Faker::PhoneNumber.area_code}-#{Faker::PhoneNumber.exchange_code}-
#{Faker::PhoneNumber.subscriber_number}"
  end
end
