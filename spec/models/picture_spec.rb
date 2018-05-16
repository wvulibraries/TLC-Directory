require 'rails_helper'

RSpec.describe Picture, type: :model do
  it { should belong_to(:imageable) }
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif', 'image/jpg').
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:image).
                less_than(2.megabytes) }

  it "has a valid factory" do
    picture = FactoryBot.create(:picture)
    expect(picture).to be_valid
    expect(picture).to be_persisted
  end
end
