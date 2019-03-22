# frozen_string_literal: true

# Resume based on documentation from carrierwave.
class CSVUploader < CarrierWave::Uploader::Base
  storage :file

  # directories to use for cache and storage
  def cache_dir
    "#{Rails.root}/public/uploads/#{Rails.env}/csv/tmp/"
  end

  # store directory
  def store_dir
    "#{Rails.root}/public/uploads/#{Rails.env}/csv/"
  end

  # extension whitelist
  def extension_whitelist
    %w[csv]
  end
end
