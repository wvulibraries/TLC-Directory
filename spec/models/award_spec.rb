require 'rails_helper'

RSpec.describe Award, type: :model do
  it { should belong_to(:user) }

  it "has a valid factory" do
    user = FactoryBot.create(:user)
    award = FactoryBot.create(:award, user: user)
    expect(award).to be_valid
    expect(award).to be_persisted
  end
end
