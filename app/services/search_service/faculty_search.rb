module SearchService
    class FacultySearch

        def initialize(params = {})
            @college_id = params[:college]
            @dept_id = params[:department]
            @search_term = params[:search]
        end

        def perform
            return full_query unless passed_params?

            build_query 
            execute_query
        end

        private
            def passed_params?
                @search_term.present? || @college_id.present? || @dept_id.present?
            end

            def setup_full_query
                @search_definition = {}
                @search_definition[:query]  = { bool:{
                    should:{
                    },
                    filter:{
                    }
                }}
            end

            def setup_basic_query
                @search_definition = {}
                @search_definition[:query]  = { bool:{
                    should:{
                    }
                }}
            end

            def setup_filtered_query
                @search_definition = {}
                @search_definition[:query]  = { bool:{
                    filter:{
                    }
                }}
            end

            def build_query
                if @search_term.present?
                    sanitized_search = Sanitize.fragment @search_term.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
                    query_array = []
                    query_array.push( {:query_string => {:query => sanitized_search}} )
                end

                # add optional filters
                term_array = []
                term_array.push( {:term => {:college_id => @college_id}} ) if @college_id.present?
                term_array.push( {:term => {:department_id => @dept_id}} ) if @dept_id.present?

                setup_full_query
                @search_definition[:query][:bool][:should] = query_array
                @search_definition[:query][:bool][:filter] = term_array 
                
                # if query_array.present? && term_array.present?
                #    setup_full_query
                #    @search_definition[:query][:bool][:should] = query_array
                #    @search_definition[:query][:bool][:filter] = term_array
                # elsif query_array.present?
                #    setup_basic_query
                #    @search_definition[:query][:bool][:should] = query_array
                # elsif term_array.present?
                #   setup_filtered_query
                #   @search_definition[:query][:bool][:filter] = term_array
                # end
            end

            def full_query
                @results = Faculty.includes(:college, :department)
                                .where(visible: true, status: 'enabled')
                                .order(:last_name, :first_name)
            end

            def execute_query
                 puts @search_definition.inspect
                 @results = Faculty.search(@search_definition, size: 1000).records
                    .includes(:college, :department)
                    .where(visible: true, status: 'enabled')
                    .order(:last_name, :first_name)
            end
    end
end
