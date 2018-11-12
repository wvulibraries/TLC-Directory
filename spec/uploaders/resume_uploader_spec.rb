require 'rails_helper'
require 'carrierwave/test/matchers'

describe ResumeUploader do
  include CarrierWave::Test::Matchers

  let(:faculty) { double('faculty') }
  let(:uploader) { ResumeUploader.new(faculty, :resume) }

  before do
    ResumeUploader.enable_processing = true
    File.open("#{Rails.root}/spec/support/files/resume_1.pdf") { |f| uploader.store!(f) }
  end

  after do
    ResumeUploader.enable_processing = false
    uploader.remove!
  end

  context 'secruity concerns' do
    it 'makes the image readable only to the owner and not executable' do
      expect(uploader).to have_permissions(0o644)
    end
  end

  context 'coverage report' do
    it 'checks cache folder' do
      tmp_path = "#{Rails.root}/public/uploads/test/resume/tmp/"
      expect(uploader.cache_dir).to eq(tmp_path)
    end 
    it 'checks upload folder' do
      up_path = "#{Rails.root}/public/uploads/test/resume/r_spec/mocks/double/"
      expect(uploader.store_dir).to eq(up_path)
    end
    it 'checks whitelist types' do
      files =  %w[pdf]
      expect(uploader.extension_whitelist).to eq(files)
    end
    it 'expects a default file' do
      expect(uploader.default_url).to eq(nil)
    end
  end
end