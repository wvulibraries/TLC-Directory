FactoryBot.define do
  factory :university do
    name { Faker::University.name }
  end
end
