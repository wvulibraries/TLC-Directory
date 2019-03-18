require 'csv'
require 'rails_helper'

RSpec.describe CSVService::CSVImport do

  describe 'methods included in module' do
    let(:uploader) { CSVUploader.new( :csv ) }
    let(:csv_service) { CSVService::CSVImport.new}

    before do
      CSVUploader.enable_processing = true
      File.open("#{Rails.root}/spec/support/files/PCI.csv") { |f| uploader.store!(f) }
    end

    after do
      CSVUploader.enable_processing = false
      uploader.remove!
    end

    it 'perform import with valid params' do
        csv_service.process_files
        
        # verify count
        expect(csv_service.import_count).to eql(1)     
    end

  end
end