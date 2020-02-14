source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Rails Specific 
# =====================================================================================

# Rails, MySQL, Puma
gem 'rails', '~> 5.2.0'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 4.3'

# Rails Dependencies
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# loads rails apps faster 
gem 'bootsnap', '>= 1.1.0', require: false

# Application Specific 
# =====================================================================================

# validators
gem 'validate_url'

# security
gem 'sanitize'

# interface items
gem 'carrierwave', '~> 1.2', '>= 1.2.3'
gem 'mini_magick'
gem 'multi-select-rails'

# cas client
gem 'rack-cas', '~> 0.16.0'

# managing cron jobs
gem 'whenever', require: false

# frontend
gem 'normalize-scss'
gem 'font-awesome-sass'
gem "non-stupid-digest-assets" # generates assets without fingerprint for 404 and 500 errors. 

# searching / indexing for speeds / pagination for elegance
# gem 'kaminari'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# Test Suite
# =====================================================================================
group :test do
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver', '~> 3.14'
  gem 'elasticsearch-extensions'
  gem 'executables'
  gem 'rspec_junit_formatter'
end

# Developoment / Test Items (Primarily debugging)
# =====================================================================================
group :development, :test do
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # from rails new
  gem 'pry'
  gem 'pry-rails'
  gem 'factory_bot_rails'
  gem 'webmock'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # performance helper
  gem 'bullet' # helps to eliminate N+1 Queries 
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]