FactoryBot.define do
  factory :email_address do
    email_address { Faker::Internet.email }

    factory :email_address_user_association do
      association :emailable, factory: :user_faker
    end
  end
end
