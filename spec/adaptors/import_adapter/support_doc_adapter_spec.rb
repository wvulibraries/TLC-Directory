# frozen_string_literal: true

require 'csv'
require 'rails_helper'

RSpec.describe ImportAdapter::SupportDocAdapter do
  describe 'methods included in module' do
    let(:faculty) { FactoryBot.attributes_for :faculty }
    let(:college) { FactoryBot.attributes_for :college }
    let(:dept) { FactoryBot.attributes_for :department }

    let(:header) { 'First Name' + ',' + 'Middle Name' + ',' + 'Last Name' + ',' + 'Email' + ',' + 'College (Most Recent)' + ',' + 'Section (Department of Medicine Only) (Most Recent)' + ',' + 'Unit (Most Recent)' + ',' + 'USERNAME' + ',' + 'UPLOAD_CV' + ',' + 'YR_YEAR' }
    let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username] + ',' + 'resume_1.pdf' + ',' + '2019' }
    let(:rows) { [header, row2] }

    let(:file_path) { 'tmp/SUPPORT_DOC.csv' }
    let!(:csv) do
      CSV.open(file_path, 'w') do |csv|
        rows.each do |row|
          csv << row.split(',')
        end
      end
    end

    after(:each) { File.delete(file_path) }

    context 'testing external file download' do
    #   it 'tries to perform import without remote enviromental settings present' do
    #     adaptor = ImportAdapter::SupportDocAdapter.new(filename: file_path)
    #     adaptor.import
    #     # count should still be one even if we were unable to retrieve 
    #     # remote file
    #     expect(adaptor.import_count).to eql(1)
    #   end

      it 'tries to perform import with invalid remote server settings present' do
        ENV['DMEASURES_URL'] = 'http://remotesite.com/'
        ENV['DMEASURES_USER'] = 'username'
        ENV['DMEASURES_PW'] = 'password'

        adaptor = ImportAdapter::SupportDocAdapter.new(filename: file_path)
        adaptor.import
        # count should still be one even if we were unable to retrieve 
        # remote file
        expect(adaptor.import_count).to eql(1)
      end
    end

    # context "with complete csv file" do
    #   it 'perform import with valid params' do
    #     ENV["DMEASURES_URL"] = "http://localhost:3000/"
    #     # ENV["DMEASURES_USER"] =
    #     # ENV["DMEASURES_PW"] =

    #     adaptor = ImportAdapter::SupportDocAdapter.new({:filename => file_path})
    #     adaptor.import
    #     # verify count
    #     expect(adaptor.import_count).to eql(1)
    #   end
    # end

    # context "test file download" do

    #   it "downloads a file from remote server"
    #     temp_file = "#{Rails.root}/spec/support/files/resume_1.pdf"
    #     uri = URI(ENV["DMEASURES_URL"] + 'resume_1.pdf')
    #     adaptor = ImportAdapter::SupportDocAdapter.new
    #     expect(adaptor.download_file(uri, temp_file)).to eq(false)
    #   end

    # end
  end
end
