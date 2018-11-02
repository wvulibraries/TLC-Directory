require 'rails_helper'

RSpec.describe Faculty, type: :model do
  let(:faculty) { FactoryBot.create(:faculty) }

  # it { should validate_presence_of(:college) }
  # it { should validate_presence_of(:department)  }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:biography) }  
  it { should validate_presence_of(:research_interests) } 

  it { should have_many(:awards) }
  it { should have_many(:addresses) }
  it { should have_many(:phones) }
  it { should have_many(:publications) }
  it { should have_many(:websites) }

  # it 'can add picture to faculty' do
  #   faculty.picture = FactoryBot.create(:picture)
  #   expect(faculty).to be_valid
  #   expect(faculty).to be_persisted
  # end

  # it 'can add document to faculty' do
  #   faculty.document = FactoryBot.create(:document)
  #   expect(faculty).to be_valid
  #   expect(faculty).to be_persisted
  # end

  # it 'has default role as user' do
  #   expect(faculty.role).to eq('user')
  # end

  # it 'change role to admin' do
  #   faculty.update_attributes(role: :admin)
  #   expect(faculty.role).to eq('admin')
  # end

  # it 'change role to editor' do
  #   faculty.update_attributes(role: :editor)
  #   expect(faculty.role).to eq('editor')
  # end
  # 
  # it 'has default status of disabled' do
  #   expect(faculty.status).to eq('disabled')
  # end
  # 
  # it 'change status to active' do
  #   faculty.update_attributes(status: :active)
  #   expect(faculty.status).to eq('active')
  # end
  # 
  # it 'has default visible set to false' do
  #   expect(faculty.visible).to eq(false)
  # end
  # 
  # it 'change faculty to visible' do
  #   faculty.update_attributes(visible: true)
  #   expect(faculty.visible).to eq(true)
  # end

  # it 'faculty has no profile picture' do
  #   expect(faculty.picture.image_file_name).to eq(nil)
  # end

end
