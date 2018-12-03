# encoding: utf-8

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)

# require suport files 
Dir[Rails.root.join('spec', 'support', '*.rb')].each { |f| require f }
Dir[Rails.root.join('spec', 'support', 'shared', 'concerns', '*.rb')].each { |f| require f }

ENV['RAILS_ENV'] ||= 'test'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
   config.infer_spec_type_from_file_location!
   config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    # Choose one or more libraries:
    with.library :active_record
    with.library :active_model
    with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end
