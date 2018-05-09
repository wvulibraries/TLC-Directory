require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should belong_to(:user) }

  it "has a valid factory" do
    user = FactoryBot.create(:user)
    address = FactoryBot.create(:address, user: user)
    expect(address).to be_valid
    expect(address).to be_persisted
  end
end
