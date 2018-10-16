require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }

  it 'validate user not admin' do
    # user.update_attributes(role: :admin)
    expect(isadmin?(user)).to eq(false)
  end  
  
  it 'validate user is admin' do
    user.update_attributes(role: :admin)
    expect(isadmin?(user)).to eq(true)
  end
  
  it 'validates user has no picture' do
    expect(haspicture?(user)).to eq(false)    
  end
  
  it 'validates user has no awards' do
    expect(hasawards?(user)).to eq(false)    
  end
  
  it 'validates user has no addresses' do
    expect(hasaddresses?(user)).to eq(false)    
  end

  it 'validates user has no email addresses' do
    expect(hasemailaddresses?(user)).to eq(false)    
  end

  it 'validates user has no phones' do
    expect(hasphones?(user)).to eq(false)    
  end

  it 'validates user has no profile' do
    expect(hasprofile?(user)).to eq(false)    
  end

  it 'validates user has no publications' do
    expect(haspublications?(user)).to eq(false)    
  end

  it 'validates user has no enrollments' do
    expect(hasenrollments?(user)).to eq(false)    
  end

  it 'validates user has no websites' do
    expect(haswebsites?(user)).to eq(false)    
  end

  it 'validates user has no universities' do
    expect(hasuniversities?(user)).to eq(false)    
  end

end