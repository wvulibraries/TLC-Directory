# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }

  it 'validate user not admin' do
    expect(isadmin?(user)).to eq(false)
  end

  it 'validate user is admin' do
    user.update_attributes(role: :admin)
    expect(isadmin?(user)).to eq(true)
  end

  it 'validates user has email' do
    expect(hasemail?(user)).to eq(true)
  end

  it 'validates user has wvu_username' do
    expect(hasusername?(user)).to eq(true)
  end
end
