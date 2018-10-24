require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it { should validate_presence_of(:wvu_username) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:first_name) }
  it { should validate_inclusion_of(:visible).in_array([true, false]) }

  it { should have_many(:awards) }
  it { should have_many(:addresses) }
  it { should have_many(:email_addresses) }
  it { should have_many(:phones) }
  it { should have_many(:publications) }
  it { should have_many(:websites) }

  it 'can add picture to user' do
    user.picture = FactoryBot.create(:picture)
    expect(user).to be_valid
    expect(user).to be_persisted
  end

  it 'can add document to user' do
    user.document = FactoryBot.create(:document)
    expect(user).to be_valid
    expect(user).to be_persisted
  end

  it 'has default role as user' do
    expect(user.role).to eq('user')
  end

  it 'change role to admin' do
    user.update_attributes(role: :admin)
    expect(user.role).to eq('admin')
  end

  it 'change role to editor' do
    user.update_attributes(role: :editor)
    expect(user.role).to eq('editor')
  end

  it 'has default status of disabled' do
    expect(user.status).to eq('disabled')
  end

  it 'change status to active' do
    user.update_attributes(status: :active)
    expect(user.status).to eq('active')
  end

  it 'has default visible set to false' do
    expect(user.visible).to eq(false)
  end

  it 'change user to visible' do
    user.update_attributes(visible: true)
    expect(user.visible).to eq(true)
  end

  it 'user has no profile picture' do
    expect(user.picture.image_file_name).to eq(nil)
  end

end
