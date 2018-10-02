FactoryBot.define do
  factory :website do
    website_url { Faker::Internet.url }

    factory :website_user_association do
      association :webable, factory: :user_faker
    end
  end
end
