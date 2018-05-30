require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TLCDirectory
  class Application < Rails::Application
    ## Set Configuration of Time Zone Here
    ## Although this should be handled by the server
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local
    config.forced_ssl = true
    config.autoload_paths += %W(#{config.root}/lib) # add this line
  end
end
