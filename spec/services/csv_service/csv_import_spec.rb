require 'csv'
require 'rails_helper'

RSpec.describe CSVService::CSVImport do

  describe 'methods included in module' do
    let(:uploader) { CSVUploader.new( :csv ) }
    let(:csv_service) { CSVService::CSVImport.new}

    let(:faculty) { FactoryBot.attributes_for :faculty }
    let(:college) { FactoryBot.attributes_for :college }
    let(:dept) { FactoryBot.attributes_for :department }

    let(:header) { "First Name" + ',' + "Middle Name" + ',' +  "Last Name" + ',' + "Email"  + ',' + "College (Most Recent)" + ',' + "Section (Department of Medicine Only) (Most Recent)" + ',' + "Unit (Most Recent)" + ',' + "USERNAME" }
    let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username]}
    let(:rows) { [header, row2] }    

    let!(:csv) do
      CSV.open(file_path, "w") do |csv|
        rows.each do |row|
          csv << row.split(",")
        end
      end
    end

    after(:each) { File.delete(file_path) }

    before do
      CSVUploader.enable_processing = true
      File.open(file_path) do |f| 
        uploader.store!(f)
      end
    end

    after do
      CSVUploader.enable_processing = false
      uploader.remove!
    end

    context "with ADMIN.csv file" do 
      let(:file_path) { "tmp/ADMIN.csv" }
      it 'perform import with valid params' do
          csv_service.process_files
          
          # verify count
          expect(csv_service.import_count).to eql(1)     
      end
    end

    context "with valid ADMIN_PERM.csv file" do 
      let(:file_path) { "tmp/ADMIN_PERM.csv" }
      it 'perform import with valid params' do
          csv_service.process_files
          
          # verify count
          expect(csv_service.import_count).to eql(1)     
      end
    end
   
    context "with valid AWARDHONOR.csv file" do 
      let(:file_path) { "tmp/AWARDHONOR.csv" }
      it 'perform import with valid params' do
          csv_service.process_files
          
          # verify count
          expect(csv_service.import_count).to eql(1)     
      end
    end   

    context "with valid PCI.csv file" do 
      let(:file_path) { "tmp/PCI.csv" }
      it 'perform import with valid params' do
          csv_service.process_files
          
          # verify count
          expect(csv_service.import_count).to eql(1)     
      end
    end

    # context "with valid INTELLCONT.csv file" do 
    #   let(:file_path) { "tmp/INTELLCONT.csv" }
    #   it 'perform import with valid params' do
    #       csv_service.process_files
          
    #       # verify count
    #       expect(csv_service.import_count).to eql(1)     
    #   end
    # end

    # context "with valid SUPPORT_DOC.csv file" do 
    #   let(:file_path) { "tmp/SUPPORT_DOC.csv" }
    #   it 'perform import with valid params' do
    #       csv_service.process_files
          
    #       # verify count
    #       expect(csv_service.import_count).to eql(1)     
    #   end
    # end  
    
    context "with valid Random.csv file" do 
      let(:file_path) { "tmp/Random.csv" }
      it 'perform import with valid params' do
          csv_service.process_files
          
          # verify count
          expect(csv_service.import_count).to eql(1)     
      end
    end    

  end
end