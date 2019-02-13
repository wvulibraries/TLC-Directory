module ImportAdapter  
    class BaseAdapter
        require 'csv'

        attr_reader :import_count
                
        def initialize(params = {})
            @filename = params[:filename]        
        end

        def import
            file = File.open(@filename, File::RDWR)
            strVar = file.readline
            removed = strVar.slice!(0, 1)
            file.rewind
            file.puts(strVar)
            file.close

            puts removed.inspect
            puts strVar.inspect

            @import_count = 0        
            CSV.foreach(@filename, headers: true, encoding: 'windows-1251:utf-8', liberal_parsing: true) do |row|
                puts row.inspect
                # Find faculty
                @faculty = Faculty.find_by(wvu_username: row["USERNAME"]) || Faculty.new(get_faculty_fields(row))
                add_optional_items(row)
                @faculty.save(validate: false)
                @import_count += 1
            end
            return true       
        end

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            false
        end

        def get_faculty_fields(row)
            puts row.inspect
            hash = {}
            # Common Fields in all CSV Files
            hash[:first_name] = row["First Name"]
            hash[:middle_name] = row["Middle Name"]
            hash[:last_name] = row["Last Name"] 
            hash[:email] = row["Email"]
            hash[:college] = College.find_or_create_by(name: row["College (Most Recent)"]) unless row["College (Most Recent)"].nil?
            hash[:department] = Department.find_or_create_by(name: row["Section (Department of Medicine Only) (Most Recent)"]) || Department.find_or_create_by(name: row["Unit (Most Recent)"])
            hash[:wvu_username] = row["USERNAME"]

            hash[:preferred_name] = row["PFNAME"]
            hash[:prefix] = row["PREFIX"]
            hash[:suffix] = row["SUFFIX"]
            hash[:title] = row["RANK"] || row["SRANK"]

            # default values
            hash[:role] = :user
            hash[:status] = 'enabled'
            hash[:visible] = true

            # find or create optional items
            return hash
        end          
    end
end