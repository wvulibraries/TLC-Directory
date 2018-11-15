FactoryBot.define do
  factory :college do
    name { Faker::University.name }
    status { 'enabled' }    
  end
end
