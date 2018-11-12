FactoryBot.define do
  factory :image do
    image { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
  end
end
