# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    prefix { Faker::Name.prefix }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    suffix { Faker::Name.suffix }
    email { "#{Faker::Internet.username(specifier: 7..37)}@mail.wvu.edu" }
    wvu_username { Faker::Internet.username(specifier: 7..37) }
    role { :user }
    status { :disabled }
    visible { false }

    factory :user_faker do
      status { rand(0..1) }
      role { rand(0..2) }
      visible { rand > 0.5 }
    end
  end
end
