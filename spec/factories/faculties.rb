# frozen_string_literal: true

FactoryBot.define do
  factory :faculty do
    prefix { Faker::Name.prefix }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    suffix { Faker::Name.suffix }
    email { "#{Faker::Internet.username(specifier: 7..37)}@mail.wvu.edu" }
    wvu_username { Faker::Internet.username(specifier: 7..37) }
    status { 'enabled' }
    role { rand(0..1) }
    visible { true }
    title { Faker::Job.title }
    biography { Faker::Lorem.paragraph(sentence_count: rand(1...5)) }
    research_interests { Faker::Lorem.sentence }
    teaching_interests { Faker::Lorem.sentence }
    tags { Faker::Lorem.words(number: 3) }

    factory :non_admin_cas do
      wvu_username { 'johntest' }
      role { 0 }
    end

    factory :admin_cas do
      wvu_username { 'johntest' }
      role { 1 }
    end

    factory :disabled_faculty do
      status { 'disabled' }
    end
  end
end
