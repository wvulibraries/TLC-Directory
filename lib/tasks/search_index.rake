require 'rake'
namespace :search_index do
  desc 'Re-index all environments'
  task all: :environment do
    Rake::Task['search_index:faculty'].invoke
    Rake::Task['search_index:college'].invoke
    # Rake::Task['search_index:department'].invoke
  end

  desc 'Properly Index Faculties'
  task faculty: :environment do
    puts "Indexing Faculties"
    Faculty.import force: true
    disabled = Faculty.where(status: 'disabled')
    disabled.each { |e| e.__elasticsearch__.delete_document }
  end

  desc 'Properly Index Colleges'
  task college: :environment do
    puts "Indexing Colleges"
    College.import force: true
    disabled = College.where(status: 'disabled')
    disabled.each { |e| e.__elasticsearch__.delete_document }
  end

  desc 'Properly Index Departments'
  task department: :environment do
    puts "Indexing Departments"
    Department.import force: true
    disabled = Department.where(status: 'disabled')
    disabled.each { |e| e.__elasticsearch__.delete_document }
  end
end