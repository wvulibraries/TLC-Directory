require 'csv'
require 'rails_helper'

RSpec.describe ImportAdapter::BaseAdapter do
  describe 'methods included in module' do
    let(:faculty) { FactoryBot.attributes_for :faculty }
    let(:college) { FactoryBot.attributes_for :college }
    let(:dept) { FactoryBot.attributes_for :department }

    let(:faculty2) { FactoryBot.attributes_for :faculty }
    let(:college2) { FactoryBot.attributes_for :college }
    let(:dept2) { FactoryBot.attributes_for :department }
    
    let(:header) { "First Name" + ',' + "Middle Name" + ',' +  "Last Name" + ',' + "Email"  + ',' + "College (Most Recent)" + ',' + "Section (Department of Medicine Only) (Most Recent)" + ',' + "Unit (Most Recent)" + ',' + "USERNAME" }
    let(:row2) { faculty[:first_name] + ',' + faculty[:middle_name] + ',' + faculty[:last_name] + ',' + faculty[:email] + ',' + college[:name] + ',,' + dept[:name] + ',' + faculty[:wvu_username]}
    let(:row3) { faculty2[:first_name] + ',' + faculty2[:middle_name] + ',' + faculty2[:last_name] + ',' + faculty2[:email] + ',' + college2[:name] + ',,' + dept2[:name] + ',' + faculty2[:wvu_username]}
    let(:rows) { [header, row2, row3] }    

    let(:file_path) { "tmp/PCI.csv" }
    let!(:csv) do
      CSV.open(file_path, "w") do |csv|
        rows.each do |row|
          csv << row.split(",")
        end
      end
    end

    after(:each) { File.delete(file_path) }

    context "with complete csv file" do
      it 'perform import with valid params' do
          adaptor = ImportAdapter::BaseAdapter.new({:filename => file_path})
          adaptor.import
          # verify count
          expect(adaptor.import_count).to eql(2)     
      end
    end
    
    context "with missing row data" do
      let(:row3) { faculty2[:first_name] + ',' + faculty2[:middle_name] + ',' + faculty2[:last_name] + ',' + faculty2[:email] + ',' + college2[:name] + ',,' + dept2[:name] + ',,'}

      it 'perform import with missing username on row 3' do
        adaptor = ImportAdapter::BaseAdapter.new({:filename => file_path})
        adaptor.import
        # verify count
        expect(adaptor.import_count).to eql(1)     
      end
    end

  end
end