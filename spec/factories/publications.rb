FactoryBot.define do
  factory :publication do
    starting_year { Time.current.year - rand(25) }
    ending_year { Time.current.year }
    title { Faker::Lorem.words(3) }
    author { Faker::University.name }
    description { Faker::Lorem.words(4) }
    url { Faker::Internet.url }
    volume { Faker::Number.number(4).to_i }
    issue { Faker::Number.number(4).to_i }

    factory :publication_user_association do
      association :publishable, factory: :user_faker
    end
  end
end
