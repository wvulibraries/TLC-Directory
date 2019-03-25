# frozen_string_literal: true

require 'csv'
require 'rails_helper'

RSpec.describe ImportAdapter::PublicationAdapter do
  describe 'methods included in module' do
    let(:faculty) { FactoryBot.attributes_for :faculty }
    let(:college) { FactoryBot.attributes_for :college }
    let(:dept) { FactoryBot.attributes_for :department }
    let(:award) { FactoryBot.attributes_for :award }

    let(:header) { 'First Name' + ',' + 'Middle Name' + ',' + 'Last Name' + ',' + 'Email' + ',' + 'College (Most Recent)' + ',' + 'Section (Department of Medicine Only) (Most Recent)' + ',' + 'Unit (Most Recent)' + ',' + 'USERNAME' + ',' + 'DTY_START' + ',' + 'DTY_END' + ',' + 'NAME' + ',' + 'ORG' + ',' + 'DESC' }
    let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username] + ',' +  award[:starting_year].to_s + ',' + award[:ending_year].to_s + ',' + award[:name].to_s + ',' + award[:organization] + ',' + award[:description] }
    let(:rows) { [header, row2] }

    let(:file_path) { 'tmp/AWARDHONOR.csv' }
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
        adaptor = ImportAdapter::AwardAdapter.new(filename: file_path)
        adaptor.import
        # verify count
        expect(adaptor.import_count).to eql(1)
      end
    end
  end
end
