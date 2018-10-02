FactoryBot.define do
  factory :address do
    street_address_1 { Faker::Address.street_address }
    street_address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }

    factory :address_user_association do
      association :addressable, factory: :user_faker
    end
  end
end
