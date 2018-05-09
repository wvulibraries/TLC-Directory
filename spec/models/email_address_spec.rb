require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  it { should belong_to(:user) }

  it "has a valid factory" do
    email = FactoryBot.create(:email_address)
    expect(email).to be_valid
    expect(email).to be_persisted
  end
end
