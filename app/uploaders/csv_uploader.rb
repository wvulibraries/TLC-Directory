# Resume based on documentation from carrierwave.
#
# @author David J. Davis
# @uploader
# @since 0.0.1
class CSVUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
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