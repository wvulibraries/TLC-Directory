require 'rails_helper'

RSpec.describe Website, type: :model do
  it { should belong_to(:webable) }

  context 'validations' do
    it { should validate_length_of(:website_url).is_at_least(10) }
    it { should validate_length_of(:website_url).is_at_most(50) }
    it { should validate_presence_of(:website_url) }
  end

  context 'valid object' do
    it 'expects website to be valid' do
      expect(website).to be_valid
    end
  end
end
