FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name(7..25) }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    role :user
    status :disabled
    visible false
  end
end
