require 'rails_helper'

RSpec.describe CSVService::FacultyImport do
  describe 'methods included in module' do
    let(:faculty_import_no_params) { CSVService::FacultyImport.new }
    let(:faculty_import_valid_filename) { CSVService::FacultyImport.new( {:filename => "#{Rails.root}/spec/support/files/PCI.csv" } )}
    let(:faculty_import_invalid_filename) { CSVService::FacultyImport.new( {:filename => "#{Rails.root}/spec/support/files/invalid.csv" } )}  

    it 'verify error with no params' do
        expect(faculty_import_no_params.error).to eql('Error: Filename Cannot be Blank')                    
    end

    it 'verify' do
        expect(faculty_import_valid_filename.valid_file?).to eql(true)    
    end

    it 'verify error with no params' do
        expect(faculty_import_no_params.error).to eql('Error: Filename Cannot be Blank')                    
    end

    it 'perform import with valid params' do
        faculty_import_valid_filename.perform
        expect(faculty_import_valid_filename.import_count).to eql(4)     
    end

  end
end