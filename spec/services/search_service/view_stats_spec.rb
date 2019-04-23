# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService::ViewStats do
  describe 'methods included in module' do
    let(:stats_no_params) { SearchService::ViewStats.new }
    # set month to current month. factory will create search_term for current month as well.
    let(:stats_valid_month) { SearchService::ViewStats.new(date: { month: Date.today.strftime('%m') }) }
    let(:stats_invalid_month) { SearchService::ViewStats.new(date: { month: 'Invalid' }) }

    before(:each) do
      FactoryBot.create :search_term
    end

    it 'verify error is nil with no params' do
      expect(stats_no_params.error).to eql(nil)
      expect(stats_no_params.perform.count).to eql(1)
    end

    it 'verify error is nil with valid month' do
      expect(stats_valid_month.error).to eql(nil)
      expect(stats_valid_month.perform.count).to eql(1)
    end

    it 'verify invalid value produces error message' do
      expect(stats_invalid_month.error).to eql('Error: Value Passed for Month Is Invalid')
      expect(stats_invalid_month.perform.count).to eql(0)
    end
  end
end
