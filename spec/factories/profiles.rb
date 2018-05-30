FactoryBot.define do
  factory :profile do
    title { Faker::Lorem.sentence }
    biography { Faker::Lorem.paragraph(rand(5...10)) }
    research_interests { Faker::Lorem.paragraph(rand(5...10)) }
  end
end
