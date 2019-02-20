module CSVService 
    class ZipImport
        include ImportAdapter

        require 'zip'
        attr_reader :errors
 
        def initialize(params = {})
            # path for zip files
            @zip_directory = "#{Rails.root}/public/uploads/#{Rails.env}/zip/"
            @zip_file = params[:zip_file]
            if @zip_file.present?
                store_file 
                extract_files              
            end
        end

        def extract_files
            files = Dir.glob(@zip_directory + "*.zip")
            files.each do |file|
                Zip::File.open(file) do |zipfile|
                    zipfile.glob('*.csv') do |csvfile|
                        zipfile.extract(csvfile.name, "#{Rails.root}/public/uploads/#{Rails.env}/csv/" + csvfile.name){ true }
                    end
                end   
                # move each file after it has been extracted to the csv folder
                completed_directory_name = @zip_directory + 'completed' + '/'
                Dir.mkdir(completed_directory_name) unless File.exists?(completed_directory_name)             
                File.rename @zip_directory + File.basename(file), completed_directory_name + File.basename(file)
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