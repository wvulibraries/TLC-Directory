FactoryBot.define do
  factory :searchterm do
    term { Faker::Name.first_name }
    yearmonth { Date.today.strftime("%Y%m") }
    term_count { rand(1..100) }
  end
end
