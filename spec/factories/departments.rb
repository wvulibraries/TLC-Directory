FactoryBot.define do
  factory :department do
    sequence(:name) { Faker::Company.industry }
    status { 'enabled' }
  end
end
