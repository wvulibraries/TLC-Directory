FactoryBot.define do
  factory :award do
    starting_year { Time.current.year - rand(25) }
    ending_year { Time.current.year }
    description { Faker::Lorem.words(4) }

    factory :award_user_association do
      association :awardable, factory: :user_faker
    end
  end
end
