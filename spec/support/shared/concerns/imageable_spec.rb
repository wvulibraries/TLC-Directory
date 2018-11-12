require 'rails_helper'

RSpec.shared_examples 'imageable' do
  let(:model) { described_class } # the class that includes the concern
  context 'imageable spec' do
    it 'expects to have an image' do
      obj = FactoryBot.create(model.to_s.underscore.to_sym, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/files/test_1.jpg'), 'image/jpeg'))
      expect(obj.no_image?).to eq false
      expect(obj.no_image?).to be_in([true, false])
    end

    it 'expects imageable to not have an image' do
      obj = FactoryBot.create(model.to_s.underscore.to_sym, image: 'nil')
      expect(obj.no_image?).to be_in([true, false])
      expect(obj.no_image?).to eq true
    end
  end
end