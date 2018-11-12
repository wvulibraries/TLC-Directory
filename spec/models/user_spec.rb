require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create :user }

  context 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_length_of(:first_name).is_at_most(70) }

    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(2) }
    it { should validate_length_of(:last_name).is_at_most(70) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:wvu_username) }
    it { should validate_length_of(:wvu_username).is_at_least(4) }
    it { should validate_length_of(:wvu_username).is_at_most(70) }
  end
  
  context 'custom validation .valid_email' do
    it 'expects a valid email response' do
      expect(user).to be_valid
    end 

    it 'expects email to be invalid as anything, but .edu at the end' do
      user.email = Faker::Internet.email
      expect(user).to_not be_valid
      expect(user.errors.messages[:email]).to eq ['must be a valid WVU email.']
    end
  end

  context 'testing enums' do
    it { should define_enum_for(:status).with(%i[disabled enabled]) }
    it { should define_enum_for(:role).with(%i[user editor admin]) }
  end

  context '.display_name' do
    it 'expects display name to have all the proper items by joining what exists and what does not exist' do
      name = [user.first_name, user.middle_name, user.last_name].join(' ')
      expect(user.display_name).to eq(name)
    end
  
    it 'expects display name to user preferred name instead of first name' do
      user.preferred_name = 'Jo Jo'
      name = [user.preferred_name, user.middle_name, user.last_name].join(' ')
      expect(user.display_name).to eq(name)
    end
  end

  context '.name' do
    it 'expectsname to have all the proper items by joining what exists and what does not exist' do
      name = [user.first_name, user.last_name].join(' ')
      expect(user.name).to eq(name)
    end

    it 'expects display name to user preferred name instead of first name' do
      user.preferred_name = 'Jo Jo'
      name = [user.preferred_name, user.last_name].join(' ')
      expect(user.name).to eq(name)
    end
  end

  context '.admin?' do
    it 'should true user is an admin because user is an admin and enabled' do
      user.role = 2
      user.status = 1
      expect(user.role).to eq 'admin'
      expect(user.admin?).to eq true
    end

    it 'should return false user is not an admin' do
      user.role = 0
      user.status = 1
      expect(user.role).to eq 'user'
      expect(user.status).to eq 'enabled'
      expect(user.admin?).to eq false
    end

    it 'should return false because the user is not active' do
      user.role = 1
      user.status = 0
      expect(user.admin?).to eq false
    end

    it 'should return a boolean even if the role is not valid' do
      user.role = nil
      expect(user.admin?).to eq false
    end

    it 'should return a boolean even if the status is not valid' do
      user.status = nil
      expect(user.admin?).to eq false
    end
  end

  context '.status?' do
    it 'should return true user is enabled' do
      user.status = 1
      expect(user.status?).to eq true
    end

    it 'should return false user is not an admin' do
      user.status = 0
      expect(user.status?).to eq false
    end

    it 'should return a boolean even if the role is not valid' do
      user.status = nil
      expect(user.status?).to eq false
    end
  end
  
  context '.visible?' do
    it 'should return true user is visible' do
      user.visible = true
      user.status = 1
      expect(user.visible?).to eq true
    end

    it 'should return false user is not visible' do
      user.visible = false
      user.status = 1      
      expect(user.visible?).to eq false
    end
    
    it 'should return true user is enabled' do
      user.visible = true
      user.status = 1      
      expect(user.visible?).to eq true
    end    
    
    it 'should return false user is disabled' do
      user.visible = true
      user.status = 0      
      expect(user.visible?).to eq false
    end    

    it 'should return a boolean even if the visible is not valid' do
      user.visible = nil
      expect(user.visible?).to eq false
    end
  end  
end