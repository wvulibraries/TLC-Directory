require 'rails_helper'

RSpec.describe Website, type: :model do
  let(:website) { FactoryBot.create :website_user_association }

  it { should belong_to(:webable) }

  context 'validations' do
    it { should validate_presence_of(:url) }
  end

  context 'valid object' do
    it 'expects website to be valid' do
      expect(website).to be_valid
    end
  end
end
