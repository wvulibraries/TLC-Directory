FactoryBot.define do
  factory :email_address do
    email { Faker::Internet.email }
  end
end
