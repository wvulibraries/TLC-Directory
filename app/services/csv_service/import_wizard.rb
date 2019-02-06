module CSVService 
    class ImportWizard
        require 'csv'

        def initialize(params = {})
            # Merge if true we will attempt add new records to database
            @mearge = params[:merge]
            @overwrite = parms[:overwrite]
        end

        def perform
            clear_faculty unless @merge == 'true'

        end
        
        private

        def clear_faculty
        end

        def 
        end

    end
end