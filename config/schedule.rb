
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