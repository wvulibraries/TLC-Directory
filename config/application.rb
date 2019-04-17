require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TLCDirectory
  class Application < Rails::Application
    # Time Zone
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    # autoload paths
    config.autoload_paths += %W(#{config.root}/lib) # add this line

    # CAS
    config.rack_cas.server_url = 'https://ssodev.wvu.edu/cas/' unless Rails.env.production?
    config.rack_cas.server_url = 'https://sso.wvu.edu/cas/' if Rails.env.production?

    # force ssl
    config.force_ssl = true if Rails.env.production?

    # session store
    config.session_store :cookie_store, expire_after: nil, secure: true if Rails.env.production?
    config.session_store :cookie_store, key: 'cas', expire_after: 12.hours, secure: true if Rails.env.production?
  end
end
