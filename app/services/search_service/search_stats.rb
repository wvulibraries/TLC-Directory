# frozen_string_literal: true

module SearchService
  class SearchStats
    require 'date'

    def initialize(params = {})
      search_string = params[:search]

      return unless search_string.present? && !search_string.empty?

      current_month = Date.today.strftime('%m')
      current_year = Date.today.strftime('%Y')
      sanitized_search = Sanitize.fragment search_string.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')

      search_item = SearchTerm.by_year(current_year)
                              .by_month(current_month)
                              .find_by(term: sanitized_search)
      if search_item.present?
        search_item.increase_count
      else
        search_item = SearchTerm.new(term: sanitized_search)
        search_item.save
      end
    end
  end
end
