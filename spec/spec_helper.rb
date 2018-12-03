require 'simplecov'
require 'simplecov-console'
ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # clear uploads after tests are complete
  config.after(:each) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # alternative configs
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.default_formatter = 'doc'
  config.order = :random
end

SimpleCov.formatter = SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  add_filter %r{^/spec/}
  add_filter %r{^/bin/}
  add_filter %r{^/config/}
  add_filter %r{^/app/helpers/}
  add_filter 'app/controllers/concerns/authenticatable.rb'
end
