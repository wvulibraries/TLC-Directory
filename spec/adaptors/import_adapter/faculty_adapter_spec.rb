# frozen_string_literal: true

require 'csv'
require 'rails_helper'

RSpec.describe ImportAdapter::FacultyAdapter do
  describe 'methods included in module' do
    let(:faculty) { FactoryBot.attributes_for :faculty }
    let(:college) { FactoryBot.attributes_for :college }
    let(:dept) { FactoryBot.attributes_for :department }

    let(:header) { 'First Name' + ',' + 'Middle Name' + ',' + 'Last Name' + ',' + 'Email' + ',' + 'College (Most Recent)' + ',' + 'Section (Department of Medicine Only) (Most Recent)' + ',' + 'Unit (Most Recent)' + ',' + 'USERNAME' + ',' + 'ophone1' + ',' + 'ophone2' + ',' + 'ophone3' + ',' + 'ophone4' }
    let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username] + ',' + '999' + ',' + '999' + ',' + '9999' + ',' + '999' }
    let(:rows) { [header, row2] }

    let(:file_path) { 'tmp/PCI.csv' }
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
        adaptor = ImportAdapter::FacultyAdapter.new(filename: file_path)
        adaptor.import
        # verify count
        expect(adaptor.import_count).to eql(1)
      end
    end
  end
end
