# frozen_string_literal: true

require 'csv'
require 'rails_helper'

RSpec.describe ImportAdapter::PublicationAdapter do
  describe 'methods included in module' do
    let(:faculty) { FactoryBot.attributes_for :faculty }
    let(:college) { FactoryBot.attributes_for :college }
    let(:dept) { FactoryBot.attributes_for :department }
    let(:pub) { FactoryBot.attributes_for :publication }

    let(:header) { 'First Name' + ',' + 'Middle Name' + ',' + 'Last Name' + ',' + 'Email' + ',' + 'College (Most Recent)' + ',' + 'Section (Department of Medicine Only) (Most Recent)' + ',' + 'Unit (Most Recent)' + ',' + 'USERNAME' + ',' + 'TITLE' + ',' + 'STATUS' + ',' + 'PUBLISHER' + ',' + 'PAGENUM' + ',' + 'ISSUE' + ',' + 'VOLUME' + ',' + 'DTY_START' + ',' + 'DTY_END' + ',' + 'WEB_ADDRESS' + ',' + 'ABSTRACT' + ',' + 'INTELLCONT_AUTH_1_FNAME' + ',' + 'INTELLCONT_AUTH_1_LNAME' }
    let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username] + ',' + pub[:title] + ',' + pub[:status] + ',' + pub[:publisher] + ',' + pub[:pagenum].to_s + ',' + pub[:issue].to_s + ',' + pub[:volume].to_s + ',' + pub[:starting_year].to_s + ',' + pub[:ending_year].to_s + ',' + pub[:url] + ',' + pub[:description] + ',' + faculty[:first_name] + ',' + faculty[:last_name] }
    let(:rows) { [header, row2] }

    let(:file_path) { 'tmp/INTELLCONT.csv' }
    let!(:csv) do
      CSV.open(file_path, 'w') do |csv|
        rows.each do |row|
          csv << row.split(',')
        end
      end
    end

    after(:each) { File.delete(file_path) }

    context 'with complete csv file' do
      it 'perform import with valid params' do
        adaptor = ImportAdapter::PublicationAdapter.new(filename: file_path)
        adaptor.import
        # verify count
        expect(adaptor.import_count).to eql(1)
      end
    end
  end
end
