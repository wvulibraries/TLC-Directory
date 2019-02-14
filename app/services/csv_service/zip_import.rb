module CSVService 
    class ZipImport
        include ImportAdapter

        require 'csv'
        attr_reader :errors
 
        def initialize(params = {})
            @zip_file = params[:zip_file]
            store_file
            queue_job
        end

        def queue_job
        end
        
        private

        def store_file
            @errors = []
            # working uploader with carrierwave store multiple files
            if @zip_file.present?
                uploader = ZIPUploader.new
                begin
                    uploader.store!(@zip_file)
                rescue Exception => e
                    @errors << e.to_s + ' ' + @zip_file.original_filename + ' Not Saved'
                end
            end       
        end

    end
end