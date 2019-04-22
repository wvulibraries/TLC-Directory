# frozen_string_literal: true

module ImportAdapter
  class SupportDocAdapter < BaseAdapter
    require 'net/http'
    require 'openssl'

    def initialize(params = {})
      # create tmp folder needed for testing seems to be missing
      @temp_folder = "#{Rails.root}/public/uploads/#{Rails.env}/resume/tmp/"
      Dir.mkdir(@temp_folder) unless File.exist?(@temp_folder)

      # calling inherited init
      super
    end

    def import
      # guard clasue added to the import to insure that valid 
      # envirmoental variables are set
      return unless valid_enviromental_vars?

      # calling inherited import
      super
    end

    private

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      return unless row[:upload_cv].present? && @faculty.resume_year.to_i < row[:yr_year].to_i

      response = download_file(row[:upload_cv].gsub(' ', '%20'))

      return unless response

      temp_file = @temp_folder + File.basename(row[:upload_cv])
      write_file(temp_file, response)
      @faculty.resume_year = row[:yr_year]
      @faculty.resume = File.open(temp_file)
      @faculty.save
      FileUtils.rm temp_file, force: true
    end

    def download_file(file)
      uri = URI(ENV['DMEASURES_URL'] + file)
      Net::HTTP.start(uri.host, uri.port,
                      use_ssl: uri.scheme == 'https',
                      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        request = Net::HTTP::Get.new uri.request_uri
        request.basic_auth ENV['DMEASURES_USER'], ENV['DMEASURES_PW']
        return http.request request # Net::HTTPResponse object
      end
    end

    def write_file(filename, response)
      return unless filename.present? && response.body.present?

      File.open(filename, 'wb') do |file|
        file.write(response.body)
        file.close
      end
    end

    def valid_enviromental_vars?
      ENV['DMEASURES_URL'].present? && ENV['DMEASURES_USER'].present? && ENV['DMEASURES_PW'].present?
    end
  end
end
