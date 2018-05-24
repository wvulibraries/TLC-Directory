require 'rails_helper'

RSpec.describe Research, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }

  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    research = FactoryBot.create(:research, :description, user: user)
    expect(research).to be_valid
    expect(research).to be_persisted
  end

  it 'When the user does not have any researches' do
    user = FactoryBot.create(:user)
    expect(user.researches.length).to eq(0)
  end

end
