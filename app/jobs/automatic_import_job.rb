# frozen_string_literal: true

class AutomaticImportJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    puts 'Starting the job.'
    import = CSVService::CSVImport.new
    import.start_import
  rescue => e
    # format body of the email
    body = "This is the error thrown: #{e}. \n\n StackTrace: #{e.backtrace.join("\n")}"
    abort "Could not complete the automatic import."
  end
end
