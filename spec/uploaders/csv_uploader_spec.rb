# frozen_string_literal: true

require 'rails_helper'
require 'carrierwave/test/matchers'

describe CSVUploader do
  include CarrierWave::Test::Matchers

  let(:uploader) { CSVUploader.new }

  before do
    CSVUploader.enable_processing = true
    File.open("#{Rails.root}/spec/support/files/PCI.csv") { |f| uploader.store!(f) }
  end

  after do
    CSVUploader.enable_processing = false
    uploader.remove!
  end

  context 'security concerns' do
    it 'makes the image readable only to the owner and not executable' do
      expect(uploader).to have_permissions(0o644)
    end
  end

  context 'coverage report' do
    it 'checks whitelist types' do
      files =  %w[csv]
      expect(uploader.extension_whitelist).to eq(files)
    end
    it 'expects a default file' do
      expect(uploader.default_url).to eq(nil)
    end
  end
end
