FactoryBot.define do
  factory :picture do
    image { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
  end
end
