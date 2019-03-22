# frozen_string_literal: true

module SearchService
  class ViewStats
    require 'date'

    attr_reader :error

    def initialize(params = {})
      unless params[:date].nil? || params[:date][:month].nil?
        @month_id = params[:date][:month]
        @error = 'Error: Value Passed for Month Is Invalid' unless valid_month?
      end
    end

    def perform
      return valid_month? ? view_month : top_terms unless error
      [] # return empty array since the each statement in view errors if nil is returned
    end

    private

    def view_month
      # get current year and month
      currentyear = Date.today.strftime('%Y')
      currentmonth = Date.today.strftime('%m')
      searchyear = @month_id.to_i <= currentmonth.to_i ? currentyear : (currentyear.to_i - 1).to_s
      SearchTerm.by_year(searchyear).by_month(@month_id).order('term_count DESC').limit(50).map(&:attributes)
    end

    def top_terms
      terms = SearchTerm.all.group(:term).sum(:term_count)
      results = []
      terms.each do |item|
        results << { 'term' => item[0], 'term_count' => item[1].to_s }
      end

      # sort by decending
      sorted = results.sort_by { |h| h['term_count'] }.reverse
      sorted.take(50) # only return the top 50
    end

    def valid_month?
      @month_id.present? && (1..12).cover?(@month_id.to_i)
    end
  end
end
