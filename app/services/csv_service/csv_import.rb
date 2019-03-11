module CSVService 
    class CSVImport
        include ImportAdapter

        require 'csv'
        attr_reader :errors
 
        def initialize(params = {})
            @path = "#{Rails.root}/public/uploads/#{Rails.env}/csv/"
            @directory_name = @path + "imported"
            @csv_files = params[:csv_files]
            store_files if @csv_files.present?
        end

        def process_files
            # get all csv files in directory
            files = Dir.glob(@path + "*.csv")
            files.each do |file|
                case File.basename(file)                                     
                when "AWARDHONOR.csv"
                    ImportAdapter::AwardAdapter.new({:filename => file}).import
                when "PCI.csv"
                    ImportAdapter::FacultyAdapter.new({:filename => file}).import
                when "INTELLCONT.csv"
                    ImportAdapter::PublicationAdapter.new({:filename => file}).import    
                when "SUPPORT_DOC.csv"
                    ImportAdapter::SupportDocAdapter.new({:filename => file}).import 
                else
                    ImportAdapter::BaseAdapter.new({:filename => file}).import  
                end

                # move each file after it has been imported into a separate folder
                Dir.mkdir(@directory_name) unless File.exists?(@directory_name)    
                File.rename file, @directory_name + File.basename(file)
            end

            FileUtils.rm_rf(@directory_name)
        end
        
        private

        def store_files
            @errors = []
            # working uploader with carrierwave store multiple files
            if @csv_files.present?
                uploader = CSVUploader.new
                @csv_files.each do |file|
                    begin
                        uploader.store!(file)
                    rescue Exception => e
                        @errors << e.to_s + ' ' + file.original_filename + ' Not Saved'
                    end
                end
            end       
        end

    end
end