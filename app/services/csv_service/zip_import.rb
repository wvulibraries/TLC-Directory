module CSVService 
    class ZipImport
        include ImportAdapter

        require 'zip'
        attr_reader :errors
 
        def initialize(params = {})
            # path for zip files
            @zip_directory = "#{Rails.root}/public/uploads/#{Rails.env}/zip/"
            @zip_file = params[:zip_file]
            store_file if @zip_file.present?
            extract_files
            process_files
        end

        def process_files
            # process extracted csv files 
            CSVService::CSVImport.new

            completed_directory_name = @zip_directory + 'completed' + '/'
            # move each file after it has been imported into a separate folder
            Dir.mkdir(completed_directory_name) unless File.exists?(completed_directory_name)             
            File.rename @zip_directory + @zip_file.original_filename, completed_directory_name + @zip_file.original_filename
        end

        def extract_files
            files = Dir.glob(@zip_directory + "*.zip")
            files.each do |file|
                Zip::File.open(file) do |zipfile|
                    zipfile.glob('*.csv') do |csvfile|
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