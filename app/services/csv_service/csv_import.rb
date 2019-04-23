# frozen_string_literal: true

module CSVService
  class CSVImport
    include ImportAdapter

    require 'csv'
    attr_reader :errors
    attr_reader :import_count

    def set_paths
      # path for csv files
      @path = "#{Rails.root}/public/uploads/#{Rails.env}"
      @csv_path = @path + '/csv/'
      @directory_name = @csv_path + 'imported'
    end

    def create_folders
      # create folders if missing
      FileUtils.mkdir_p(@directory_name) unless File.exist?(@directory_name)
    end

    def initialize(params = {})
      set_paths
      create_folders
      @csv_files = params[:csv_files]
      @import_count = 0
      store_files if @csv_files.present?
    end

    def process_files
      # get all csv files in directory
      files = Dir.glob(@csv_path + '*.csv')
      files.each do |file|
        case File.basename(file)
        when 'ADMIN.csv'
          ImportAdapter::AdminAdapter.new(filename: file).import
        when 'ADMIN_PERM.csv'
          ImportAdapter::AdminPermAdapter.new(filename: file).import
        when 'AWARDHONOR.csv'
          ImportAdapter::AwardAdapter.new(filename: file).import
        when 'PCI.csv'
          ImportAdapter::FacultyAdapter.new(filename: file).import
        when 'INTELLCONT.csv'
          ImportAdapter::PublicationAdapter.new(filename: file).import
        when 'SUPPORT_DOC.csv'
          ImportAdapter::SupportDocAdapter.new(filename: file).import
        else
          ImportAdapter::BaseAdapter.new(filename: file).import
        end

        # increase count
        @import_count += 1

        # move each file after it has been imported into a separate folder
        Dir.mkdir(@directory_name) unless File.exist?(@directory_name)
        File.rename file, @directory_name + '/' + File.basename(file)
      end

      FileUtils.rm_rf(@directory_name)
    end

    private

    def store_files
      return unless @csv_files.present?

      @errors = []
      # working uploader with carrierwave store multiple files
      uploader = CSVUploader.new
      @csv_files.each do |file|
        uploader.store!(file)
      rescue StandardError => error
        @errors << error.to_s + ' ' + file.original_filename + ' Not Saved'
      end
    end
  end
end
