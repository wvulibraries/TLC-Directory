# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryBot.create :address_user_association }

  context 'validates .' do
    it { should validate_length_of(:street_address_1).is_at_most(50) }
    it { should validate_length_of(:street_address_2).is_at_most(50) }
    it { should validate_length_of(:city).is_at_most(60) }
    it { should validate_length_of(:state).is_at_most(50) }
    it { should validate_length_of(:zip_code).is_at_most(20) }
  end

  context 'associations' do
    it { should belong_to(:addressable) }
  end

  context 'testing the factory valid' do
    it 'expects address to be valid' do
      expect(address).to be_valid
    end
  end

  describe '#human_readable' do
    it 'expects address to be human readable' do
      format = "#{address.street_address_1} #{address.street_address_2}, #{address.city}, #{address.state} #{address.zip_code}"
      expect(address.human_readable).to eq(format)
    end

    it 'expects a string value from the model' do
      expect(address.human_readable.class).to eq(String)
    end
  end
end
