FactoryBot.define do
  factory :website do
    website_url { Faker::Internet.url }
  end
end
