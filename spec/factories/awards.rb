FactoryBot.define do
  factory :award do
    starting_year { Date.today.year-5 }
    ending_year { Date.today.year }
    description { Faker::Lorem.words(4) }
  end
end
