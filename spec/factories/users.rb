FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    full_name { Faker::Name.name }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    role :user
    status :disabled
    visible false
  end
end
