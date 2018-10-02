FactoryBot.define do
  factory :user do
    prefix { Faker::Name.prefix }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    suffix { Faker::Name.suffix }
    wvu_username { Faker::Internet.user_name(7..25) }
    role :user
    status :disabled
    visible false

    factory :user_faker do
      status { rand(0..1) }
      role { rand(0..2) }
      visible { rand > 0.5 }
    end
  end
end
