FactoryBot.define do
  factory :college do
    sequence(:name) { |n| "#{Faker::University.name} #{n}" }
    status { 'enabled' }
    
    factory :disabled_college do
      status { 'disabled' }
    end
  end
end
