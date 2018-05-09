require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:bio) }

  it "has a valid factory" do
    profile = FactoryBot.create(:profile)
    expect(profile).to be_valid
    expect(profile).to be_persisted
  end


end
