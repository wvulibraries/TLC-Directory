# set environmentals
env :PATH, ENV['PATH']
env :GEM_HOME, ENV['GEM_HOME']
env :BUNDLE_APP_CONFIG, ENV['BUNDLE_APP_CONFIG']
env :RUBY_MAJOR, ENV['RUBY_MAJOR']
env :RUBYGEMS_VERSION, ENV['RUBYGEMS_VERSION']
env :BUNDLE_BIN, ENV['BUNDLE_BIN']
env :BUNDLE_PATH, ENV['BUNDLE_PATH']
env :RUBY_VERSION, ENV['RUBY_VERSION']
env :BUNDLER_VERSION, ENV['BUNDLER_VERSION']

# needs to set environments for MYSQL
env :MYSQL_PASSWORD, ENV['MYSQL_PASSWORD']
env :MYSQL_HOST, ENV['MYSQL_HOST']
env :MYSQL_PORT, ENV['MYSQL_PORT']

# set logs and environment
set :output, {:standard => "/home/tlcdirectory/log/cron.log", :error => "/home/tlcdirectory/log/cron_error.log"}
set :environment, 'production'

# run cleanup 1st day of every month
every '0 2 1 * *' do
  command 'cd /home/tlcdirectory && rake cleanup_searchterm' 
end

# clobber the tmp folder daily and logs to keep files small 
every 1.day do
  command 'cd /home/tlcdirectory && rake log:clear'
  command 'cd /home/tlcdirectory && bin/rails tmp:clear'
end