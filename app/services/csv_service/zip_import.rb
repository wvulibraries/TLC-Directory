# frozen_string_literal: true

module CSVService
  class ZipImport
    include ImportAdapter

    require 'zip'
    attr_reader :errors

    def set_paths
      # path for csv files
      @path = "#{Rails.root}/public/uploads/#{Rails.env}"
      current_datetime = DateTime.now
      @subfolder = current_datetime.to_time.to_i
      @csv_path = @path + '/csv/' + @subfolder.to_s + '/'
      @zip_path = @path + '/zip/'
      @completed_zip_path = @zip_path + 'completed' + '/'
    end

    def create_folders
      # create folders if missing
      FileUtils.mkdir_p(@csv_path) unless File.exist?(@csv_path)
      FileUtils.mkdir_p(@completed_zip_path) unless File.exist?(@completed_zip_path)
    end

    def initialize(params = {})
      set_paths
      create_folders

      @zip_file = params[:zip_file]
      return unless @zip_file.present?

      store_file
      extract_files
    end

    def extract_files
      files = Dir.glob(@zip_path + '*.zip')
      files.each do |file|
        Zip::File.open(file) do |zipfile|
          zipfile.glob('*.csv') do |csvfile|
            zipfile.extract(csvfile.name, @csv_path + csvfile.name) { true }
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
      return unless @zip_file.present?

      uploader = ZIPUploader.new
      begin
        uploader.store!(@zip_file)
      rescue StandardError => error
        @errors << error.to_s + ' ' + @zip_file.original_filename + ' Not Saved'
      end
    end
  end
end
