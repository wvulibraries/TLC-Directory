# frozen_string_literal: true

FactoryBot.define do
  factory :publication do
    starting_year { Time.current.year - rand(25) }
    ending_year { Time.current.year }
    status { 'Published' }
    title { Faker::Lorem.sentence(3, true) }
    author { Faker::University.name }
    publisher { Faker::Company.name }
    description { Faker::Lorem.paragraph(2) }
    url { Faker::Internet.url }
    volume { Faker::Number.number(4).to_i }
    issue { Faker::Number.number(4).to_i }
    pagenum { Faker::Number.number(4).to_i }

    factory :publication_user_association do
      association :publishable, factory: :user_faker
    end
  end
end
