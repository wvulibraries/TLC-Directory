require 'rails_helper'

RSpec.describe Faculty, type: :model do
  let(:faculty) { FactoryBot.create :faculty }
  # let(:faculty_phone) { FactoryBot.create :faculty_with_phone }
  # let(:faculty_address) { FactoryBot.create :faculty_with_address }

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:title).is_at_most(70) }

    # it { should validate_presence_of(:university_classification) }
    # it { should validate_length_of(:university_classification).is_at_least(2) }
    # it { should validate_length_of(:university_classification).is_at_most(70) }

    it { should validate_length_of(:biography).is_at_most(500) }
  end

  context 'associations' do
    it { should have_many(:awards) }
    it { should have_many(:addresses) }
    it { should have_many(:phones) }
    it { should have_many(:publications) }
    it { should have_many(:websites) }
  end

  context 'image uploader' do
    it_behaves_like 'imageable'
  end
  
  context 'resume uploader' do
    it 'resume? should be true' do
      obj = FactoryBot.create(:faculty, resume: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/files/resume_1.pdf'), 'image/pdf'))
      expect(obj.resume?).to eq true
      expect(obj.resume?).to be_in([true, false])
    end
  
    it 'resume? should be false' do
      obj = FactoryBot.create(:faculty, resume: nil)
      expect(obj.resume?).to eq false
      expect(obj.resume?).to be_in([true, false])
    end
  
    it 'should not take any other formats' do
      obj = FactoryBot.build(:faculty, resume: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/files/test_1.jpg'), 'image/jpeg'))
      expect(obj.valid?).to eq false
      expect(obj.errors[:resume].first).to eq('You are not allowed to upload "jpg" files, allowed types: pdf')
    end
  end

  describe 'elasticsearch' do
    before do
      faculty # instantiate faculty
    end
    
    context 'determining indexes' do
      it 'should be indexed' do
        name = faculty.first_name
        Faculty.import(force: true, refresh: true)
        expect(Faculty.search(name).records.length).to eq(1)
      end
    end
    
  end

  describe 'conditional elasticsearch indexing using callbacks' do
    before do
      faculty # instantiate
      Faculty.import(force: true, refresh: true)
    end
  
    context 'conditional indexes' do
      
      it 'a new record should be indexed' do
        new_faculty = FactoryBot.create :faculty
        Faculty.__elasticsearch__.refresh_index!
        expect(Faculty.search(new_faculty.first_name).records.length).to be >= 1
      end    
      
      it 'a new disabled record should not be indexed' do
        new_faculty = FactoryBot.create :disabled_faculty
        Faculty.__elasticsearch__.refresh_index!
        expect(Faculty.search(new_faculty.first_name).records.length).to eq 0  
      end  
      
      # it 'updated disabled faculty to enabled' do
      #   new_faculty = FactoryBot.create :disabled_faculty
      #   Faculty.__elasticsearch__.refresh_index!
      #   expect(Faculty.search(new_faculty.first_name).records.length).to eq 0  
      #   new_faculty.update(status: 'enabled')      
      #   Faculty.__elasticsearch__.refresh_index!
      #   sleep 2
      #   expect(Faculty.search(new_faculty.first_name).records.length).to eq 1                             
      # end    
    
      it 'should remove faculty after the update because of the status' do
        Faculty.__elasticsearch__.refresh_index!
        faculty.update(status: 'disabled')
        sleep 2 # let the callbacks work
        expect(Faculty.search(faculty.first_name).records.length).to eq 0
      end    
      
      it 'should keep faculty in index after the update because of status' do
        Faculty.__elasticsearch__.refresh_index!
        faculty.update(status: 'enabled')
        sleep 2 # let the callbacks work
        expect(Faculty.search(faculty.first_name).records.length).to eq 1
      end    
      
      it 'should delete the index after destroy' do
        # verify that the faculty exists before
        expect(Faculty.search(faculty.first_name).records.length).to eq(1)
        faculty.destroy
        expect(Faculty.search(faculty.first_name).records.length).to eq(0)
      end
    
    end
  end

end

