CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  else 
    config.storage = :file
    config.enable_processing = true
  end
end