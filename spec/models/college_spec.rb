require 'rails_helper'

RSpec.describe College, type: :model do
  let(:college) { FactoryBot.create :college }
  let(:enabled_college) { FactoryBot.create :enabled_college }
  let(:disabled_college) { FactoryBot.create :disabled_college }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_length_of(:name).is_at_least(4) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should define_enum_for(:status).with(%i[enabled disabled]) }
  end

  context 'invalid options' do
    it 'expects name to be too long' do
      college.name = Faker::String.random(51)
      expect(college).to_not be_valid
      expect(college.errors.messages[:name]).to eq ['is too long (maximum is 50 characters)']
    end

    it 'expects name to be too short' do
      college.name = Faker::String.random(3)
      expect(college).to_not be_valid
      expect(college.errors.messages[:name]).to eq ['is too short (minimum is 4 characters)']
    end
  end

  describe 'elasticsearch' do
    before do
      college # instantiate college
      College.import(force: true, refresh: true)
    end
    context 'determining indexes' do
      it 'should be indexed' do
        expect(College.search(college.name).records.length).to eq 1
      end
    end
  end

  describe 'conditional elasticsearch indexing' do
    context 'conditional indexes' do
      
      before do
        College.import(force: true, refresh: true)
      end
      
      it 'a new record should be indexed' do
        enabled_college
        College.__elasticsearch__.refresh_index!     
        expect(College.search(enabled_college.name).records.length).to eq 1
      end
      
      it 'a new disabled record should not be indexed' do
        disabled_college
        College.__elasticsearch__.refresh_index!     
        expect(College.search(disabled_college.name).records.length).to eq 0  
      end         
      
      it 'updated disabled college to enabled' do
        disabled_college
        College.__elasticsearch__.refresh_index!
        expect(College.search(disabled_college.name).records.length).to eq 0     
      
        disabled_college.update(status: 'enabled')
        College.__elasticsearch__.refresh_index!
        expect(College.search(disabled_college.name).records.length).to eq 1   
      end    
      
      it 'should remove college after the update because of the status' do
        college # instantiate college        
        college.update(status: 'disabled')        
        College.__elasticsearch__.refresh_index!
        expect(College.search(college.name).records.length).to eq 0
      end
      
      it 'should keep college in index after the update because of status' do
        college # instantiate college        
        college.update(status: 'enabled')        
        College.__elasticsearch__.refresh_index!
        expect(College.search(college.name).records.length).to eq 1
      end
      
      it 'should delete the index after destroy' do
        college # instantiate college  
        College.__elasticsearch__.refresh_index!
                     
        # verify that the college exists before
        expect(College.search(college.name).records.length).to eq 1
        college.destroy
        expect(College.search(college.name).records.length).to eq 0
      end
    end
  end
end