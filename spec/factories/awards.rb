FactoryBot.define do
  factory :award do
    description { Faker::Lorem.words(4) }
  end
end
