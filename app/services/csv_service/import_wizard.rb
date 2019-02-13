module CSVService 
    class ImportWizard
        include ImportAdapter

        require 'csv'
        attr_reader :errors
 
        def initialize(params = {})
            @csv_files = params[:csv_files]
            store_files
        end

        def process_files
            files = Dir.glob("#{Rails.root}/public/uploads/#{Rails.env}/csv/*.csv")
            files.each do |file|
                case File.basename(file)                                     
                when "AWARDHONOR.csv"
                    adaptor = ImportAdapter::AwardAdapter.new({:filename => file})
                when "PCI.csv"
                    adaptor = ImportAdapter::FacultyAdapter.new({:filename => file})
                when "INTELLCONT.csv"
                    adaptor = ImportAdapter::PublicationAdapter.new({:filename => file})    
                else
                    adaptor = ImportAdapter::BaseAdapter.new({:filename => file})  
                end

                adaptor.import if adaptor.present?

                File.delete(file) if File.exist?(file)                
            end
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