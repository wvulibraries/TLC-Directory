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
    biography { Faker::Lorem.paragraph(rand(1...5)) }
    research_interests { Faker::Lorem.sentence }
    
    factory :non_admin_cas do
      wvu_username { 'johntest' }
      role { 0 }
    end

    factory :admin_cas do
      wvu_username { 'johntest' }
      role { 1 }
    end    
    
    factory :faculty_faker do
      status { rand(0..1) }
      role { rand(0..2) }
      visible { rand > 0.5 }
    end    
  end
end