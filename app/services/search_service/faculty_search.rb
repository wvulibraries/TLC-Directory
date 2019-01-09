module SearchService
    class FacultySearch

        def initialize(params)
            @college_id = params[:college] if params[:college].present?
            @dept_id = params[:department] if params[:department].present?  
            @search_term = Sanitize.fragment params[:search].gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '') if params[:search].present? 
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
                    query_array = []
                    query_array.push( {:query_string => {:query => @search_term}} )
                    @search_definition[:query][:bool][:should] = query_array
                end

                # add optional filters
                term_array = []
                term_array.push( {:term => {:college_id => @college_id}} ) if @college_id.present?
                term_array.push( {:term => {:department_id => @dept_id}} ) if @dept_id.present?
                @search_definition[:query][:bool][:filter] = term_array
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
