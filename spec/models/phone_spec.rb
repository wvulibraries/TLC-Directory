require 'rails_helper'

RSpec.describe Phone, type: :model do
  it { should belong_to(:user) }

  it "has a valid factory" do
    phone = FactoryBot.create(:phone)
    expect(phone).to be_valid
    expect(phone).to be_persisted
  end  
end
