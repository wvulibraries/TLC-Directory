require 'csv'
require 'rails_helper'

RSpec.describe CSVService::CSVImport do

  # describe 'methods included in module' do
  #   let(:faculty) { FactoryBot.attributes_for :faculty }
  #   let(:college) { FactoryBot.attributes_for :college }
  #   let(:dept) { FactoryBot.attributes_for :department }
    
  #   let(:header) { "First Name, Middle Name, Last Name, Email, College (Most Recent), Section (Department of Medicine Only) (Most Recent), Unit (Most Recent), USERNAME" }
  #   let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username]}
  #   #let(:row3) { "value1, value2, value3" }
  #   let(:rows) { [header, row2] }    

  #   let(:file_path) { "tmp/PCI.csv" }
  #   let!(:csv) do
  #     CSV.open(file_path, "w") do |csv|
  #       rows.each do |row|
  #         csv << row.split(",")
  #       end
  #     end
  #   end

    #let(:faculty_import_valid_filename) { CSVService::CSVImport.new({:csv_files => [file_path]})}

    # after(:each) { File.delete(file_path) }

    # it 'perform import with valid params' do
    #     faculty_import_valid_filename.perform
    #     # verify count
    #     expect(faculty_import_valid_filename.import_count).to eql(1)     
    # end


  #end
end