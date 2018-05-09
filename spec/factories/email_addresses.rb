FactoryBot.define do
  factory :email_address do
    user_id 1
    email { Faker::Internet.email }
  end
end
