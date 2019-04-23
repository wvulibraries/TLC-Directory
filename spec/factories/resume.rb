# frozen_string_literal: true

FactoryBot.define do
  factory :resume do
    document { File.new("#{Rails.root}/spec/support/fixtures/test.pdf") }
  end
end
