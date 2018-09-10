require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should belong_to(:user) }

  context 'validations' do
    it { should validate_length_of(:street_address_1).is_at_most(50) }
    it { should validate_length_of(:street_address_2).is_at_most(50) }
    it { should validate_length_of(:city).is_at_most(60) }
    it { should validate_length_of(:state).is_at_most(50) }
    it { should validate_length_of(:zip_code).is_at_most(20) }
  end

  it "has a valid factory" do
    user = FactoryBot.create(:user)
    address = FactoryBot.create(:address, user: user)
    expect(address).to be_valid
    expect(address).to be_persisted
  end
end
