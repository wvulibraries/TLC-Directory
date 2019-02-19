# import/cron_import.rb
# ----------------------------------------------------------------- 

# grab the arguments passed in by the script
project_name = ARGV[0]
# abort "Missing project name" if project_name.nil?

# control_dir = "/fileshare/#{project_name}/control/export"
# process_dir = "/fileshare/#{project_name}/control/in-progress"

# if there is already a control file in the processing directory, 
# exit if Dir.entries(process_dir).length > 2

# Dir.open(control_dir).sort.each do |file|
#   next if file =~ /^\./
#   control_file = YAML.load_file "#{control_dir}/#{file}"
  AutomaticImportJob.perform_now
#   break
# end