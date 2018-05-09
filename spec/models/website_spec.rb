require 'rails_helper'

RSpec.describe Website, type: :model do
  it { should belong_to(:user) }

  it "has a valid factory" do
    website = FactoryBot.create(:website)
    expect(website).to be_valid
    expect(website).to be_persisted
  end
end
