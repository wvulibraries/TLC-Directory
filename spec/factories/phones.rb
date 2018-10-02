FactoryBot.define do
  factory :phone do
    number_types { rand(0..3) }
    number { Faker::PhoneNumber.phone_number }

    factory :phone_user_association do
      association :phoneable, factory: :user_faker
    end
  end
end
