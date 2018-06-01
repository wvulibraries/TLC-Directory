require 'rails_helper'

RSpec.describe User, type: :model do
  # it { should validate_presence_of(:username) }
  # it { should validate_presence_of(:last_name) }
  # it { should validate_presence_of(:first_name) }
  # it { should validate_inclusion_of(:visible).in_array([true, false]) }
  it { should have_one(:picture) }

  it 'has a valid factory' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
    expect(user).to be_persisted
  end

  it 'has default role as user' do
    user = FactoryBot.create(:user)
    expect(user.role).to eq('user')
    expect(user.isadmin?).to eq(false)
  end

  it 'change role to admin' do
    user = FactoryBot.create(:user)
    user.update_attributes(role: :admin)
    expect(user.role).to eq('admin')
    expect(user.isadmin?).to eq(true)
  end

  it 'has default status of disabled' do
    user = FactoryBot.create(:user)
    expect(user.status).to eq('disabled')
  end

  it 'change status to active' do
    user = FactoryBot.create(:user)
    user.update_attributes(status: :active)
    expect(user.status).to eq('active')
  end

  it 'has default visible set to false' do
    user = FactoryBot.create(:user)
    expect(user.visible).to eq(false)
  end

  it 'change user to visible' do
    user = FactoryBot.create(:user)
    user.update_attributes(visible: true)
    expect(user.visible).to eq(true)
  end

  it 'user has no profile picture' do
    user = FactoryBot.create(:user)
    expect(user.haspicture?).to eq(false)
  end

  # it 'When the user does not have any universities' do
  #   user = FactoryBot.create(:user)
  #   expect(user.universities).to eq(nil)
  # end
end
