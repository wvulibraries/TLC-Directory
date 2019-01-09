module SearchService
    class FacultySearch

        def initialize(params = {})
            @college_id = params[:college]
            @dept_id = params[:department]
            @search_term = params[:search]
        end

        def perform
            if @search_term.present? || @college_id.present? || @dept_it.present?  
                build_query 
                execute_query
            else
                full_query   
            end   
        end

        private

            def build_query
                @search_definition = {}
                @search_definition[:query]  = { bool:{
                    should:{
                    },
                    filter:{
                    }
                }}

                if @search_term.present?
                    sanitized_search = Sanitize.fragment @search_term.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
                    query_array = []
                    query_array.push( {:query_string => {:query => sanitized_search}} )
                    @search_definition[:query][:bool][:should] = query_array
                end

                # add optional filters
                term_array = []
                term_array.push( {:term => {:college_id => @college_id}} ) if @college_id.present?
                term_array.push( {:term => {:department_id => @dept_id}} ) if @dept_id.present?
                @search_definition[:query][:bool][:filter] = term_array if term_array.count > 0
            end

            def full_query
                @results = Faculty.includes(:college, :department)
                                .where(visible: true, status: 'enabled')
                                .order(:last_name, :first_name)
            end

            def execute_query
                 @results = Faculty.search(@search_definition, size: 1000).records
                    .includes(:college, :department)
                    .where(visible: true, status: 'enabled')
                    .order(:last_name, :first_name)
            end
    end
end
