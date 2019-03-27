# frozen_string_literal: true

require 'csv'
require 'rails_helper'

class FakeResponse
  attr :body
  def initialize(body)
    @body = body
  end
end

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

    let(:temp_path) { "#{Rails.root}/public/uploads/#{Rails.env}/resume/tmp/" }

    before(:each) {
      FileUtils.mkdir_p(temp_path)
      FileUtils.cp("#{Rails.root}/spec/support/files/resume_1.pdf", temp_path)
    }

    let(:resume_path) { temp_path + 'resume_1.pdf' }
    let(:resume) { File.read(resume_path) }
    let(:response) { FakeResponse.new(resume) }

    context 'successful resume download' do
      it 'returns the requested file' do
        ENV['DMEASURES_URL'] = 'http://remotesite.com/'
        ENV['DMEASURES_USER'] = 'username'
        ENV['DMEASURES_PW'] = 'password'

        # Setup: Instantiate, mock
        adaptor = ImportAdapter::SupportDocAdapter.new(filename: file_path)
        allow(adaptor).to receive(:download_file).and_return(response)

        # Perform
        adaptor.import

        # Verify
        expect(adaptor.import_count).to eql(1)
      end

      it 'tries to perform import without remote enviromental settings present' do
        adaptor = ImportAdapter::SupportDocAdapter.new(filename: file_path)
        adaptor.import
        # count should still be one even if we were unable to retrieve
        # remote file
        expect(adaptor.import_count).to eql(1)
      end
    end
  end
end
