require 'rails_helper'
require 'carrierwave/test/matchers'

describe CSVUploader do
  # include CarrierWave::Test::Matchers

  # let(:uploader) { CSVUploader.new( :csv ) }

  # before do
  #   CSVUploader.enable_processing = true
  #   File.open("#{Rails.root}/spec/support/files/PCI.csv") { |f| uploader.store!(f) }
  # end

  # after do
  #   CSVUploader.enable_processing = false
  #   uploader.remove!
  # end

  # context 'security concerns' do
  #   it 'makes the image readable only to the owner and not executable' do
  #     expect(uploader).to have_permissions(0o644)
  #   end
  # end

  # context 'coverage report' do
  #   it 'checks cache folder' do
  #     tmp_path = "#{Rails.root}/public/uploads/test/csv/tmp/"
  #     expect(uploader.cache_dir).to eq(tmp_path)
  #   end 
  #   it 'checks upload folder' do
  #     up_path = "#{Rails.root}/public/uploads/test/csv/"
  #     expect(uploader.store_dir).to eq(up_path)
  #   end
  #   it 'checks whitelist types' do
  #     files =  %w[csv]
  #     expect(uploader.extension_whitelist).to eq(files)
  #   end
  #   it 'expects a default file' do
  #     expect(uploader.default_url).to eq(nil)
  #   end
  # end
end