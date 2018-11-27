FactoryBot.define do
  factory :college do
    name { Faker::University.name } 
  end
  
  trait :enabled do
    status { 'enabled' }  
  end
  
  trait :disabled do
    status { 'disabled' }  
  end  
end
