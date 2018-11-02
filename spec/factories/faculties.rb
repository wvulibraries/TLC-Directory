FactoryBot.define do
  factory :faculty do
    prefix { Faker::Name.prefix }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    suffix { Faker::Name.suffix }
    email { "#{Faker::Internet.user_name(7..36)}@mail.wvu.edu" }
    wvu_username { Faker::Internet.user_name(7..36) }    
    role :user
    status :disabled
    visible false    
    college { Faker::University.name }
    department { Faker::Company.industry  }
    title { Faker::Job.title }
    biography { Faker::Lorem.paragraph(rand(5...10)) }
    research_interests { Faker::Lorem.sentence }
    
    factory :faculty_faker do
      status { rand(0..1) }
      role { rand(0..2) }
      visible { rand > 0.5 }
    end    
  end
end