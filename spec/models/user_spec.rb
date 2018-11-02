require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it { should validate_presence_of(:wvu_username) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:email) }  
  
  it { should validate_inclusion_of(:visible).in_array([true, false]) }

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

end
