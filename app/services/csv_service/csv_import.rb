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
    end

    def initialize(params = {})
      set_paths
      @csv_files = params[:csv_files]
      @import_count = 0
      store_files if @csv_files.present?
    end

    def start_import
      # get list of folders to process
      folders = Dir.glob(@csv_path + '*')
      # loop over each folder found
      folders.each do |folder|
        # import csv files in each folder
        process_folder(folder.to_s)
      end
    end

    def process_folder(path)
      directory_name = path + '/imported'
      # make sure imported folder exists to move completed file to
      Dir.mkdir(directory_name) unless File.exist?(directory_name)

      # get all csv files in directory
      files = Dir.glob(path + '/*.csv')
      files.each do |file|
        puts "Processing #{File.basename(file)}" 
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
        # when 'SUPPORT_DOC.csv'
        #   ImportAdapter::SupportDocAdapter.new(filename: file).import
        else
          ImportAdapter::BaseAdapter.new(filename: file).import
        end

        # increase count
        @import_count += 1

        # move each file after it has been imported into a separate folder
        File.rename file, directory_name + '/' + File.basename(file)
      end

      # removed folder after import has completed
      FileUtils.rm_rf(path)
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
