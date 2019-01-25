FactoryBot.define do
  factory :search_term do
    term { Faker::Name.first_name }
    term_count { rand(1..100) }
    created_at { Faker::Date.between(364.days.ago, Date.today) }
  end
end
