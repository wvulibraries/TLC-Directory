FactoryBot.define do
  factory :research do
    trait :no_description do
      description nil
    end

    trait :description do
      description { Faker::Lorem.sentence }
    end

  end
end
