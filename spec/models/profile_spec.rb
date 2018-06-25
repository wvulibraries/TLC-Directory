require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
  # it { should validate_presence_of(:title) }
  # it { should validate_presence_of(:biography) }
  # it { should validate_presence_of(:research_interests) }

  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    profile = FactoryBot.create(:profile, user: user)
    expect(profile).to be_valid
    expect(profile).to be_persisted
  end

  it 'When the user does not have a profile' do
    user = FactoryBot.create(:user)
    expect(user.profile.department).to eq(nil)
    expect(user.profile.title).to eq(nil)
    expect(user.profile.biography).to eq(nil)
    expect(user.profile.research_interests).to eq(nil)
  end

  it 'When the user has a profile' do
    user = FactoryBot.create(:user)
    profile = FactoryBot.create(:profile, user: user)
    expect(user.profile.title).to eq(profile.title)
    expect(user.profile.biography).to eq(profile.biography)
    expect(user.profile.research_interests).to eq(profile.research_interests)
  end

end
