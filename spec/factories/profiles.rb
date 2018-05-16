FactoryBot.define do
  factory :profile do

    trait :no_bio do
      bio nil
    end

    trait :bio_mid do
      bio { Faker::Lorem.paragraph(rand(2...4)) }
    end

    trait :bio_lg do
      bio { Faker::Lorem.paragraph(rand(5...10)) }
    end
  end
end
