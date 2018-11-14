require 'rails_helper'

RSpec.describe FacultiesHelper, type: :helper do
  let(:faculty) { FactoryBot.create(:faculty) }

  it 'validate faculty not admin' do
    expect(isadmin?(faculty)).to eq(false)
  end  
  
  it 'validate faculty is admin' do
    faculty.update_attributes(role: :admin)
    expect(isadmin?(faculty)).to eq(true)
  end
  
  it 'validates faculty has image' do
    # should always be true if faculty hasn't 
    # uploaded picture a basic placeholder
    # image is used
    expect(hasimage?(faculty)).to eq(true)    
  end
  
  it 'validates faculty has no awards' do
    expect(hasawards?(faculty)).to eq(false)    
  end
  
  it 'validates faculty has no addresses' do
    expect(hasaddresses?(faculty)).to eq(false)    
  end

  it 'validates faculty has no phones' do
    expect(hasphones?(faculty)).to eq(false)    
  end

  it 'validates faculty has no publications' do
    expect(haspublications?(faculty)).to eq(false)    
  end

  it 'validates faculty has no websites' do
    expect(haswebsites?(faculty)).to eq(false)    
  end

end