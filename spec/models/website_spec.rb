require 'rails_helper'

RSpec.describe Website, type: :model do
  it { should belong_to(:webable) }

  it "has a valid factory" do
    user = FactoryBot.create(:user)
    website = FactoryBot.create(:website, user: user)
    expect(website).to be_valid
    expect(website).to be_persisted
  end

  it 'When the user does not have any websites' do
    user = FactoryBot.create(:user)
    expect(user.websites.length).to eq(0)
  end

  let(:website) { FactoryBot.create :website_user_association }

  it { should belong_to(:webable) }

  context 'validations' do
    it { should validate_length_of(:website_url).is_at_least(10) }
    it { should validate_length_of(:website_url).is_at_most(30) }
    it { should validate_presence_of(:website_url) }
  end

  context 'valid object' do
    it 'expects website to be valid' do
      expect(website).to be_valid
    end
  end
end
