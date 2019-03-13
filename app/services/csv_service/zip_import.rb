module CSVService 
    class ZipImport
        include ImportAdapter

        require 'zip'
        attr_reader :errors
 
        def initialize(params = {})
            # path for csv files
            @uploads = @path = "#{Rails.root}/public/uploads/"
            @path = @uploads + "#{Rails.env}"
            @csv_path = @path + "/csv/"
            # path for zip files
            @zip_path = @path + "/zip/"
            @completed_zip_path = @zip_path + 'completed' + '/'

            # create folders if missing
            #Dir.mkdir(@uploads) unless File.exists?(@uploads)
            Dir.mkdir(@path) unless File.exists?(@path)
            Dir.mkdir(@csv_path) unless File.exists?(@csv_path) 
            Dir.mkdir(@zip_path) unless File.exists?(@zip_path) 
            Dir.mkdir(@completed_zip_path) unless File.exists?(@completed_zip_path)

            @zip_file = params[:zip_file]
            if @zip_file.present?
                store_file 
                extract_files              
            end
        end

        def extract_files
            files = Dir.glob(@zip_path + "*.zip")
            files.each do |file|
                Zip::File.open(file) do |zipfile|
                    zipfile.glob('*.csv') do |csvfile|
                        zipfile.extract(csvfile.name, @csv_path + csvfile.name){ true }
                    end
                end   
                # move each file after it has been extracted to the csv folder
                File.rename @zip_path + File.basename(file), @completed_zip_path + File.basename(file)
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