module SearchService
    class SearchStats
        require 'date'
        
        def initialize(params = {})
            search_string = params[:search]

            if search_string.present? && search_string.length > 0
                current = Date.today.strftime("%Y%m")
                sanitized_search = Sanitize.fragment search_string.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')

                search_item = SearchTerm.find_by(term: sanitized_search, yearmonth: current)

                if search_item.present?
                    search_item.increase_count
                else
                    search_item= SearchTerm.new(term: sanitized_search, yearmonth: current, term_count: 1)
                    search_item.save
                end
            end
        end
        
    end
end
