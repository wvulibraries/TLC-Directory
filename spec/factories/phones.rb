FactoryBot.define do
  factory :phone do
    number_types { rand(0..3) }
    number { Faker::PhoneNumber.phone_number }
  end
end
