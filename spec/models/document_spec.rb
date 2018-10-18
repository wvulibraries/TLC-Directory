require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should belong_to(:documentable) }
  it { should have_attached_file(:document) }

  it "has a valid factory" do
    document = FactoryBot.create(:document)
    expect(document).to be_valid
    expect(document).to be_persisted
  end

  it 'When the user does not have a CV' do
    user = FactoryBot.create(:user)
    expect(user.document.document_file_name).to eq(nil)
    expect(user.document.document_content_type).to eq(nil)
    expect(user.document.document_file_size).to eq(nil)
  end
end
