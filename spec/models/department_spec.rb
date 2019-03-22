# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  let(:dept) { FactoryBot.create :department }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5) }
    it { should validate_length_of(:name).is_at_most(50) }
    it { should define_enum_for(:status).with(%i[enabled disabled]) }
  end

  context 'invalid options' do
    it 'expects name to be too long' do
      dept.name = Faker::String.random(51)
      expect(dept).to_not be_valid
      expect(dept.errors.messages[:name]).to include('is too long (maximum is 50 characters)')
    end

    it 'expects name to be too short' do
      dept.name = Faker::String.random(3)
      expect(dept).to_not be_valid
      expect(dept.errors.messages[:name]).to include('is too short (minimum is 5 characters)')
    end
  end

  describe 'elasticsearch' do
    context 'determining indexes' do
      it 'should be indexed' do
        dept # instantiate department
        Department.import(force: true, refresh: true)
        query = dept.name.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        expect(Department.search(query).records.count).to eq 1
      end
    end
  end

  describe 'conditional elasticsearch indexing using callbacks' do
    before do
      dept # instantiate
      Department.import(force: true, refresh: true)
    end
    context 'conditional indexes' do
      it 'a new record should be indexed' do
        new_dept = FactoryBot.create :department
        Department.__elasticsearch__.refresh_index!
        sleep 2 # let the callbacks work
        # clean query usually done in controller
        query = new_dept.name.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        expect(Department.search(query).records.count).to eq 1
      end

      it 'a new disabled record should not be indexed' do
        new_dept = FactoryBot.create :disabled_department
        Department.__elasticsearch__.refresh_index!
        sleep 2 # let the callbacks work
        # clean query usually done in controller
        query = new_dept.name.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        expect(Department.search(query).records.count).to eq(0)
      end

      it 'should remove department after the update because of the status' do
        dept.update(status: 'disabled')
        Department.__elasticsearch__.refresh_index!
        sleep 2 # let the callbacks work
        # clean query usually done in controller
        query = dept.name.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        expect(Department.search(query).records.count).to eq 0
      end

      it 'should keep department in index after the update because of status' do
        dept.update(status: 'enabled')
        Department.__elasticsearch__.refresh_index!
        sleep 2 # let the callbacks work
        # clean query usually done in controller
        query = dept.name.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        expect(Department.search(query).records.count).to eq 1
      end

      it 'should delete the index after destroy' do
        # clean query usually done in controller
        query = dept.name.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        # verify that the department exists before
        expect(Department.search(query).records.count).to eq 1
        dept.destroy
        expect(Department.search(query).records.count).to eq 0
      end
    end
  end
end
