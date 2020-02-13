# frozen_string_literal: true

# Resume based on documentation from carrierwave.
class CSVUploader < CarrierWave::Uploader::Base
  storage :file

  def initialize()
      current_datetime = DateTime.now
      @subfolder = current_datetime.to_time.to_i
  end

  # directories to use for cache and storage
  def cache_dir
    "#{Rails.root}/public/uploads/#{Rails.env}/csv/" + @subfolder.to_s + '/tmp/'
  end

  # store directory
  def store_dir
    "#{Rails.root}/public/uploads/#{Rails.env}/csv/" + @subfolder.to_s + '/'
  end

  # extension whitelist
  def extension_whitelist
    %w[csv]
  end
end
