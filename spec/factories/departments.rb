# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "#{Faker::Company.industry} #{n}" }
    status { 'enabled' }

    factory :disabled_department do
      status { 'disabled' }
    end
  end
end
