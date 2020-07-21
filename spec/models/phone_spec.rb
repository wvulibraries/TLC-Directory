# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  let(:phone) { FactoryBot.create :phone_user_association }

  it { should belong_to(:phoneable) }

  context 'validations' do
    it { should validate_length_of(:number).is_at_least(10) }
    it { should validate_length_of(:number).is_at_most(30) }
    it { should validate_presence_of(:number) }
    it { should define_enum_for(:number_types).with_values(%i[phone home fax mobile office department]) }
  end

  context 'valid object' do
    it 'expects phone to be valid' do
      expect(phone).to be_valid
    end
  end

  context '.number_types' do
    it 'Calling type should return string with type capitalized' do
      phone.number_types = 0 # set number_types to default phone
      expect(phone.type).to eql('Phone')
    end
  end
end
