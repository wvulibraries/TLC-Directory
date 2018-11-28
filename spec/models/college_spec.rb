require 'rails_helper'

RSpec.describe College, type: :model do
  let(:college) { FactoryBot.create :college }

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
        expect(College.search(college.name).records.length).to eq(1)
      end
    end
  end

  describe 'conditional elasticsearch indexing' do
    before do
      college # instantiate
      College.import(force: true, refresh: true)
    end
    context 'conditional indexes' do
      it 'a new record should be indexed' do
        new_college = FactoryBot.create :college
        College.__elasticsearch__.refresh_index!
        expect(College.search(new_college.name).records.length).to be >= 1
      end
      
      it 'a new disabled record should not be indexed' do
        new_college = FactoryBot.create :disabled_college
        College.__elasticsearch__.refresh_index!
        expect(College.search(new_college.name).records.length).to eq 0  
      end         
      
      it 'updated disabled college to enabled' do
        new_college = FactoryBot.create :disabled_college
        new_college.update(status: 'enabled')      
        College.__elasticsearch__.refresh_index!
        sleep 2
        expect(College.search(new_college.name).records.length).to eq 1        
      end  

      it 'should remove college after the update because of the status' do
        College.__elasticsearch__.refresh_index!
        college.update(status: 'disabled')
        sleep 2 # let the callbacks work
        expect(College.search(college.name).records.length).to eq 0
      end

      it 'should keep college in index after the update because of status' do
        College.__elasticsearch__.refresh_index!
        college.update(status: 'enabled')
        sleep 2 # let the callbacks work
        expect(College.search(college.name).records.length).to eq 1
      end

      it 'should delete the index after destroy' do
        # verify that the college exists before
        expect(College.search(college.name).records.length).to eq 1
        college.destroy
        expect(College.search(college.name).records.length).to eq 0
      end
    end
  end
end