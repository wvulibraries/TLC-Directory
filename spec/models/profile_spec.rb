require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:bio) }

  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    profile = FactoryBot.create(:profile, :bio_mid, user: user)
    expect(profile).to be_valid
    expect(profile).to be_persisted
  end

  it 'When the user does not have a profile' do
    user = FactoryBot.create(:user)
    expect(user.profile).to eq(nil)
  end

  it 'When the user has a profile' do
    user = FactoryBot.create(:user)
    profile = FactoryBot.create(:profile, :bio_mid, user: user)
    expect(user.profile.bio).to eq(profile.bio)
  end

  it 'When the user has a long profile' do
    user = FactoryBot.create(:user)
    profile = FactoryBot.create(:profile, :bio_lg, user: user)
    expect(user.profile.bio).to eq(profile.bio)
  end
end
