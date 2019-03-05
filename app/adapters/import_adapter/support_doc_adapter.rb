module ImportAdapter  
    class SupportDocAdapter < BaseAdapter
        require 'net/http'
        require 'openssl'       

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            if row[:upload_cv].present? && @faculty.resume_year.to_i < row[:yr_year].to_i
                file_url = ENV["DMEASURES_URL"] + row[:upload_cv].gsub(' ', '%20')
                temp_file = "#{Rails.root}/public/uploads/#{Rails.env}/resume/tmp/" + File.basename(row[:upload_cv])
                if download_file(URI(file_url), temp_file)
                    @faculty.resume_year = row[:yr_year]
                    @faculty.resume = File.open(temp_file)
                    @faculty.save 
                    FileUtils.rm temp_file, :force => true
                end
            end
        end

        def download_file(uri, temp_file)
            Net::HTTP.start(uri.host, uri.port,
                :use_ssl => uri.scheme == 'https', 
                :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
                request = Net::HTTP::Get.new uri.request_uri
                request.basic_auth ENV["DMEASURES_USER"], ENV["DMEASURES_PW"]

                response = http.request request # Net::HTTPResponse object

                open(temp_file, "wb") do |file|
                    file.write(response.body) 
                    file.close               
                end
                return true                  
            end
            return false
        end    
    end
end