require 'rake'
task :cleanup_searchterm => :environment do
  SearchTerm.where("created_at < ?", 1.year.ago(Time.zone.now)).delete_all
end