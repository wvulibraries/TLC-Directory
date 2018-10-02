require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email_address) { FactoryBot.create :email_address_user_association }

  it { should belong_to(:emailable) }

  context 'validations' do
    it { should validate_length_of(:email_address).is_at_most(50) }
  end

  context 'valid object' do
    it 'expects address to be valid' do
      expect(email_address).to be_valid
    end
  end
end
