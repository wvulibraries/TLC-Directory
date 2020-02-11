# config/schedule.rb
# -----------------------------------------------------------

# environmental variables 
env :PATH, ENV['PATH']
env :GEM_HOME, ENV['GEM_HOME']
env :BUNDLE_APP_CONFIG, ENV['BUNDLE_APP_CONFIG']
env :RUBY_MAJOR, ENV['RUBY_MAJOR']
env :RUBYGEMS_VERSION, ENV['RUBYGEMS_VERSION']
env :BUNDLE_BIN, ENV['BUNDLE_BIN']
env :BUNDLE_PATH, ENV['BUNDLE_PATH']
env :RUBY_VERSION, ENV['RUBY_VERSION']
env :BUNDLER_VERSION, ENV['BUNDLER_VERSION']
env :RAILS_ENV, ENV['RAILS_ENV']
env :ELASTICSEARCH_URL, ENV['ELASTICSEARCH_URL']
env :DMEASURES_URL, ENV['DMEASURES_URL']
env :DMEASURES_USER, ENV['DMEASURES_USER']
env :DMEASURES_PW, ENV['DMEASURES_PW']
env :DATABASE_PASSWORD, ENV['DATABASE_PASSWORD']

# set logs and environment
set :output, {:standard => "/home/sotldirectory/log/cron.log", :error => "/home/sotldirectory/log/cron_error.log"}

# run cleanup 1st day of every month
every '0 2 1 * *' do
  command 'cd /home/sotldirectory && rake cleanup_searchterm' 
end

# change to the base directory of the application
# run the file with the rails runner task 
every 1.minute do
  command 'cd /home/sotldirectory && bin/rails r import/cron_import.rb'
end

# clobber the tmp folder daily and logs to keep files small 
every 1.day do
  command 'cd /home/sotldirectory && rake log:clear'
  command 'cd /home/sotldirectory && bin/rails tmp:clear'
end
