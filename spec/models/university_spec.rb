require 'rails_helper'

RSpec.describe University, type: :model do
  it { should validate_presence_of(:name) }

  it "has a valid factory" do
    university = FactoryBot.create(:university)
    expect(university).to be_valid
    expect(university).to be_persisted
  end

end
