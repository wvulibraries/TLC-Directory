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
            []
        end       

        private

        def passed_params?(params)
            params[:date] && params[:date][:month]
        end

        def view_month
            # get current year and month
            currentyear = Date.today.strftime("%Y")
            currentmonth = Date.today.strftime("%m")
            #searchyear = if currentmonth.to_i >= @month_id .to_i then currentyear else (currentyear.to_i-1).to_s end
            searchyear = (@month_id.to_i <= currentmonth.to_i) ? currentyear : (currentyear.to_i-1).to_s
            #searchyear = currentyear
            #puts .inspect

            # puts currentmonth.inspect
            # puts @month_id.inspect

            # if currentmonth.to_i >= @month_id.to_i
            #     puts "Current Year"
            #     searchyear = currentyear
            # else
            #     puts "Previous Year"
            #     searchyear = (currentyear.to_i-1).to_s
            # end
            # puts searchyear.inspect
            SearchTerm.by_year(searchyear).by_month(@month_id).order('term_count DESC').limit(50).map(&:attributes)
        end            

        def top_terms
            terms = SearchTerm.all.group(:term).sum(:term_count)
            results  = []
            terms.each do |item|
                 results << { 'term' => item[0], 'term_count' => item[1].to_s } 
            end           

            # sort by decending
            sorted = results.sort_by { |h| h['term_count'] }.reverse
            sorted.take(50) # only return the top 50
        end

        def valid_month?
            @month_id.present? && (1..12).include?(@month_id.to_i)
        end
    end
end
