class ApplicationController < ActionController::Base
  # base setups
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info, :error

  layout 'application'

  # concerns
  include Authenticatable
end
