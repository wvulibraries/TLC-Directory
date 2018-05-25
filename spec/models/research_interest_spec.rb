require 'rails_helper'

RSpec.describe ResearchInterest, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:description) }

  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    research_interest = FactoryBot.create(:research_interest, :description, user: user)
    expect(research_interest).to be_valid
    expect(research_interest).to be_persisted
  end

  it 'When the user does not have any research_interests' do
    user = FactoryBot.create(:user)
    expect(user.research_interests.length).to eq(0)
  end

end
