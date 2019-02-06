module CSVService 
    class FacultyImport
        require 'csv'

        attr_reader :error
        attr_reader :import_count

        def initialize(params = {})
            if params[:filename].nil?    
               @error = 'Error: Filename Cannot be Blank'
            else
               @filename = params[:filename]  
               @error = 'Error: Missing File or Invalid Type' unless valid_file?            
            end            
        end

        def perform
            faculty = read_csv_file if valid_file?
        end    

        def valid_file?
            File.exist?(@filename) && valid_type?
        end

        def valid_type?
            MIME::Types.type_for(@filename).first.content_type == 'text/csv'
        end
        
        private

        def read_csv_file
            @import_count = 0
            CSV.foreach(@filename, headers: true, liberal_parsing: true) do |row|
                hash = {}
                #hash[:title] = "none"
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
                # hash[:title] = row["BIO"]
                hash[:biography] = row["BIO"]
                hash[:research_interests] = row["RESEARCH_INTERESTS"]
                hash[:teaching_interests] = row["TEACHING_INTERESTS"]
                # find or create college
                hash[:college] = find_or_create_college(row["College (Most Recent)"])
                hash[:websites] = [Website.create({:url => row["WEBSITE"]})]
                faculty = Faculty.create(hash)
                @import_count += 1
                # puts faculty.inspect
                # return faculty.last_name
            end
            return true
        end

        def find_or_create_college(name = nil)
            College.where(name: name).first || College.create({:name => name}) unless name.nil?
        end

    end
end