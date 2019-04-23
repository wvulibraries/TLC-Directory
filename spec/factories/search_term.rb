# frozen_string_literal: true

FactoryBot.define do
  factory :search_term do
    term { Faker::Name.first_name }
    term_count { rand(1..100) }
    created_at { Date.today }
  end
end
