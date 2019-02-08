module CSVService 
    class ImportWizard
        require 'csv'
        attr_reader :errors
 
        def initialize(params = {})
            @csv_files = params[:csv_files]
            store_files
        end

        def process_files
            files = Dir.glob("#{Rails.root}/public/uploads/#{Rails.env}/csv/*.csv")
            files.each do |file|
                #headers = CSV.open(file, 'r', liberal_parsing: true) { |csv| csv.first }

                case File.basename(file)
                when "AWARDHONOR.csv"
                    import = CSVService::AwardImport.new({:filename => file})
                when "PCI.csv"
                    import = CSVService::FacultyImport.new({:filename => file})
                else
                    @errors << "Unknown CSV File"
                end

                import.perform if import.present?
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