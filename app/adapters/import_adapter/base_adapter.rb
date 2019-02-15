module ImportAdapter  
    class BaseAdapter
        require 'csv'

        attr_reader :import_count
                
        def initialize(params = {})
            @filename = params[:filename]        
        end

        def import
            @import_count = 0
            CSV.foreach(@filename, headers: true, :header_converters => lambda { |h| h.gsub(/[^0-9A-Za-z_\s]/, '').downcase.gsub(/\s+/, "_").to_sym unless h.nil? }, liberal_parsing: true) do |row|       
                #puts row.inspect
                # Find faculty
                @faculty = Faculty.where(wvu_username: row[:username]).first_or_initialize
                set_faculty_fields(row)
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

        def set_faculty_fields(row)
            hash = {}
            # Common Fields in all CSV Files
            hash[:first_name] = row[:first_name] unless row[:first_name].nil?
            hash[:middle_name] = row[:middle_name] unless row[:middle_name].nil?
            hash[:last_name] = row[:last_name] unless row[:last_name].nil?
            hash[:email] = row[:email].downcase unless row[:email].nil?
            hash[:college] = College.find_or_create_by(name: row[:college_most_recent]) unless row[:college_most_recent].nil?

            if row[:unit_most_recent].present?
                hash[:department] = Department.find_or_create_by(name: row[:unit_most_recent])
            elsif row[:section_department_of_medicine_only_most_recent].present?
                hash[:department] = Department.find_or_create_by(name: row[:section_department_of_medicine_only_most_recent])
            end
             
            hash[:wvu_username] = row[:username].downcase unless row[:username].nil?

            # These fields are not in all csv files
            hash[:biography] = row[:bio] unless row[:bio].nil?
            hash[:research_interests] = row[:research_interests] unless row[:research_interests].nil?
            hash[:teaching_interests] = row[:teaching_interests] unless row[:teaching_interests].nil?
            hash[:preferred_name] = row[:pfname] unless row[:pfname].nil?
            hash[:prefix] = row[:prefix] unless row[:prefix].nil?
            hash[:suffix] = row[:suffix] unless row[:suffix].nil?
            hash[:title] = row[:rank] unless row[:rank].nil? || row[:srank] unless row[:srank].nil?

            # default values
            hash[:role] = :user
            hash[:status] = 'enabled'
            hash[:visible] = true

            # find or create optional items
            @faculty.attributes = hash
        end          
    end
end