FactoryBot.define do
  factory :research_interest do
    trait :no_description do
      description nil
    end

    trait :description do
      description { Faker::Lorem.sentence }
    end

  end
end
