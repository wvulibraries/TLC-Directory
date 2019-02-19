class AutomaticImportJob < ApplicationJob
  queue_as :default

#   before_perform do |job|
#     control_file = job.arguments.first
#   end

#   after_perform do |job| 
#   end

  def perform(*args)    
    # send the email
    begin  
      puts "Starting the job."
      import = CSVService::CSVImport.new
      import.process_files
    rescue => e  
      # format body of the email 
      body = "This is the error thrown: #{e}. \n\n StackTrace: #{e.backtrace.join("\n")}"
      abort "Could not complete the automatic import." 
    end
  end
end
