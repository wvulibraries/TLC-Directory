FactoryBot.define do
  factory :college do
    name { Faker::University.name }
    status { 'enabled' }
    
    factory :enabled_college do
      status { 'enabled' }
    end 
    
    factory :disabled_college do
      status { 'disabled' }
    end
  end
end
