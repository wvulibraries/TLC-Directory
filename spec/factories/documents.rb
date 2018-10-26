FactoryBot.define do
  factory :document do
    document { File.new("#{Rails.root}/spec/support/fixtures/test.pdf") }
  end
end
