module CSVService 
    class ZipImport
        include ImportAdapter

        require 'zip'
        attr_reader :errors
 
        def initialize(params = {})
            @zip_file = params[:zip_file]
            store_file if @zip_file.present?
            extract_files
            wizard = CSVService::CSVImport.new
        end

        def extract_files
            files = Dir.glob("#{Rails.root}/public/uploads/#{Rails.env}/zip/*.zip")
            files.each do |file|
                Zip::File.open(file) do |zipfile|
                    zipfile.each do |csvfile|
                        zipfile.extract(csvfile.name, "#{Rails.root}/public/uploads/#{Rails.env}/csv/" + csvfile.name){ true }
                    end
                end                
            end           
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