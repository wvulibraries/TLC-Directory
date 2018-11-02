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
  
  # it 'validates user has email' do
  # 
  # end
  # 
  # it 'validates user has wvu_username' do
  # 
  # end
  
  
  # it 'validates user has picture' do
  #   # should always be true if user hasn't 
  #   # uploaded picture a basic placeholder
  #   # image is used
  #   expect(haspicture?(user)).to eq(true)    
  # end
  
  # it 'validates user has no awards' do
  #   expect(hasawards?(user)).to eq(false)    
  # end
  # 
  # it 'validates user has no addresses' do
  #   expect(hasaddresses?(user)).to eq(false)    
  # end
  # 
  # it 'validates user has no email addresses' do
  #   expect(hasemailaddresses?(user)).to eq(false)    
  # end
  # 
  # it 'validates user has no phones' do
  #   expect(hasphones?(user)).to eq(false)    
  # end
  # 
  # it 'validates user has profile' do
  #   # all users are created with a profile 
  #   # this should always be true
  #   expect(hasprofile?(user)).to eq(true)    
  # end
  # 
  # it 'validates user has no publications' do
  #   expect(haspublications?(user)).to eq(false)    
  # end
  # 
  # it 'validates user has no websites' do
  #   expect(haswebsites?(user)).to eq(false)    
  # end

end