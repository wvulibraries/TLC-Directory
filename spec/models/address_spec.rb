require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryBot.create :address_user_association }

  it { should belong_to(:addressable) }

  context 'validations' do
    it { should validate_length_of(:street_address_1).is_at_most(50) }
    it { should validate_length_of(:street_address_2).is_at_most(50) }
    it { should validate_length_of(:city).is_at_most(60) }
    it { should validate_length_of(:state).is_at_most(50) }
    it { should validate_length_of(:zip_code).is_at_most(20) }
  end

  context 'valid object' do
    it 'expects address to be valid' do
      expect(address).to be_valid
    end
  end

end
