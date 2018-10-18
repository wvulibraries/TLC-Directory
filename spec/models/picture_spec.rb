require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { should belong_to(:imageable) }
  it { should have_attached_file(:image) }

  it "has a valid factory" do
    picture = FactoryBot.create(:picture)
    expect(picture).to be_valid
    expect(picture).to be_persisted
  end

  it 'When the user does not have a Picture' do
    user = FactoryBot.create(:user)
    expect(user.picture.image_file_name).to eq(nil)
    expect(user.picture.image_content_type).to eq(nil)
    expect(user.picture.image_file_size).to eq(nil)
  end
end
