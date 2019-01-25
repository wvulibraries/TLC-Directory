module SearchService
    class ViewStats
        require 'date'

        #validates_inclusion_of :month_id, in: 1..12

        def initialize(params = {})

            if passed_params?(params)
                @month_id = params[:date][:month] 
                format_month
            end

            #if @month_id && @month_id.match(/^((?!(0))[0-9]{9})$/)
                
            # elsif @month_id
            # raise custom error message if not valid

            #end
        end

        def perform
            return top_terms unless @month_id.present?
            view_month
        end       

        private

        def passed_params?(params)
            params[:date] && params[:date][:month]
        end

        # adds 0 to the beginning of the month if it is only 1 character
        def format_month
            if @month_id.length == 1
                @month_id = '0' + @month_id.to_s
            end
        end

        def view_month
            currentyear = Date.today.strftime("%Y")
            currentmonth = Date.today.strftime("%m")
            searchyear = if currentmonth <= @month_id then currentyear else currentyear-1 end
            SearchTerm.by_year(searchyear).by_month(@month_id).order('term_count DESC').limit(50).map(&:attributes)
        end            

        def top_terms
            term_array = SearchTerm.select(:term).map(&:term).uniq
            results  = []
            count = 0
            term_array.each do |term|
                count = SearchTerm.where(term: term).sum(:term_count)
                results << {'term' => term, 'term_count' => count.to_s }
            end
            # sort by decending
            sorted = results.sort_by { |h| h['term_count'] }.reverse
            sorted.take(50) # only return the top 50
        end
    end
end
