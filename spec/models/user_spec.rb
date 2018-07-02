require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:university) { FactoryBot.create(:university) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:first_name) }
  it { should validate_inclusion_of(:visible).in_array([true, false]) }

  it { should have_many(:awards) }
  it { should have_many(:addresses) }
  it { should have_many(:email_addresses) }
  it { should have_many(:phones) }
  it { should have_many(:publications) }
  it { should have_many(:websites) }
  it { should have_many(:enrollments) }
  it { should have_many(:universities).through(:enrollments) }

  it 'has a valid factory' do
    user.picture = FactoryBot.create(:picture)
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

  it 'When the user does not have any universities' do
    expect(user.universities.count).to eq(0)
  end

  # it 'User Can Add a New University' do
  # end

  # it 'If Admin Can add Universities w/o attaching to user or self' do
  # end

  it 'Has Many Universities' do
    expect(user).to have_many(:universities)
  end

  it 'Can add existing university' do
    user.universities << university
    expect(user.universities.count).to eq(1)
  end

  it 'Can delete existing university from collection' do
    user.universities << university
    user.universities.delete(university)
    expect(user.universities.count).to eq(0)
  end

  it 'Should allow user to have multiple universities' do
    user.universities << university
    user.universities << FactoryBot.create(:university)
    expect(user.universities.count).to eq(2)
  end

  it 'Should not be able to add same university multiple times' do
    user.universities << university
    expect { user.universities << university }.to raise_error(ActiveRecord::RecordInvalid,'Validation failed: University has already been taken')
  end


end
