FactoryBot.define do
  factory :department do
    sequence(:name) { Faker::Company.industry }
    status { 'enabled' }
    
    factory :disabled_department do
      status { 'disabled' }
    end
  end
end
