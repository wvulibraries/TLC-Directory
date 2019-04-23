# frozen_string_literal: true

# Resume based on documentation from carrierwave.
class ZIPUploader < CarrierWave::Uploader::Base
  storage :file

  # directories to use for cache and storage
  def cache_dir
    "#{Rails.root}/public/uploads/#{Rails.env}/zip/tmp/"
  end

  # store directory
  def store_dir
    "#{Rails.root}/public/uploads/#{Rails.env}/zip/"
  end

  # extension whitelist
  def extension_whitelist
    %w[zip]
  end
end
