module CSVService 
    class FacultyImport
        require 'csv'

        attr_reader :import_count

        def initialize(params = {})
            @filename = params[:filename]        
        end

        def perform
            read_csv_file
        end    
        
        private

        def read_csv_file
            @import_count = 0
            CSV.foreach(@filename, headers: true, liberal_parsing: true) do |row|
                hash = process_row(row)
                faculty = Faculty.find_by(wvu_username: hash[:wvu_username])

                if faculty.present?
                    faculty.update(hash)
                    faculty.save(validate: false)
                else
                    faculty = Faculty.new(hash)
                    faculty.save(validate: false)
                end
                @import_count += 1
            end
            return true
        end

        def process_row(row)
            hash = {}
            hash[:preferred_name] = row["PFNAME"]
            hash[:prefix] = row["PREFIX"]
            hash[:last_name] = row["LNAME"]
            hash[:first_name] = row["FNAME"]
            hash[:middle_name] = row["MNAME"]
            hash[:suffix] = row["SUFFIX"]
            hash[:email] = row["Email"]
            hash[:wvu_username] = row["USERNAME"]
            hash[:role] = :user
            hash[:status] = 'enabled'
            hash[:visible] = true
            hash[:biography] = row["BIO"]
            hash[:research_interests] = row["RESEARCH_INTERESTS"]
            hash[:teaching_interests] = row["TEACHING_INTERESTS"]

            # find or create optional items
            hash[:college] = College.find_or_create_by(name: row["College (Most Recent)"]) unless row["College (Most Recent)"].nil?
            hash[:department] = Department.find_or_create_by(name: row["Unit (Most Recent)"]) unless row["Unit (Most Recent)"].nil?
            hash[:websites] = [Website.find_or_create_by(url: row["WEBSITE"])] unless row["WEBSITE"].nil?            
            hash[:phones] = build_phone_array(row)

            return hash
        end

        def build_phone_array(row)
            phone_array = []
            phone = create_phone(row["OPHONE1"], row["OPHONE2"], row["OPHONE3"], row["OPHONE4"], 'office')
            phone_array << phone unless phone.nil?
            phone = create_phone(row["DPHONE1"],row["DPHONE2"], row["DPHONE3"], row["DPHONE4"], 'department')
            phone_array << phone unless phone.nil?
            phone = create_phone(row["FAX1"],row["FAX2"], row["FAX3"], row["FAX4"], 'fax')
            phone_array << phone unless phone.nil?
            return phone_array
        end

        def create_phone(area_code, prefix, line_number, extension, type)
            if area_code.present? && prefix.present? && line_number.present? && type.present?
                number = area_code + '.' + prefix + '.' + line_number
                # Add optional extension
                number = number + 'Ext. ' + extension if extension.present?
                Phone.find_or_create_by(number: number, number_types: type)
            end
        end

    end
end