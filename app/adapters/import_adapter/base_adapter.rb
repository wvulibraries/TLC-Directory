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
                # Find faculty
                if row[:username].present?
                    @faculty = Faculty.where(wvu_username: row[:username]).first_or_initialize 
                    if @faculty.present?
                        set_faculty_fields(row)
                        add_optional_items(row)
                        @faculty.save(validate: false)
                        @import_count += 1
                    end
                end
            end      
        end

        private

        # placeholder for adding additional fields
        def add_optional_items(row)
            false
        end

        def set_faculty_fields(row)
            # Common Fields in all CSV Files that we will get and are not modifiying
            keys = [:first_name, :middle_name, :last_name, :research_interests, :teaching_interests, :prefix, :suffix]
            hash = keys.zip(row.to_hash.values_at *keys).to_h

            # downcase the email address we are seeing sometimes they are uppercase
            hash[:email] = row[:email].downcase unless row[:email].nil?

            # find or create college
            hash[:college] = College.find_or_create_by(name: row[:college_most_recent]) unless row[:college_most_recent].nil?

            # find or create department
            if row[:unit_most_recent].present?
                hash[:department] = Department.find_or_create_by(name: row[:unit_most_recent])
            elsif row[:section_department_of_medicine_only_most_recent].present?
                hash[:department] = Department.find_or_create_by(name: row[:section_department_of_medicine_only_most_recent])
            end

            # set wvu_username convert to lowercase
            hash[:wvu_username] = row[:username].downcase unless row[:username].nil?

            # These fields are not in all csv files
            hash[:biography] = row[:bio] unless row[:bio].nil?

            hash[:preferred_name] = row[:pfname] unless row[:pfname].nil?

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