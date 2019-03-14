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
                if row[:username].present?
                    # Find faculty
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

        def default_faculty_values
            { role: :user, status: 'enabled', visible: true }
        end 

        def find_or_create_department(hash)          
            Department.find_or_create_by(name: hash[:unit_most_recent]) || Department.find_or_create_by(name: hash[:section_department_of_medicine_only_most_recent])
        end

        def filter_hash_keys(hash, keys)
            # return hash with only requried keys
            keys.zip(hash.values_at *keys).to_h           
        end

        def set_faculty_fields(row)
            # convert row to hash and set default access values for new faculty
            hash = row.to_hash.merge!(default_faculty_values)

            # downcase email
            hash[:email] = hash[:email].downcase unless hash[:email].nil?

            # set wvu_username & downcase
            hash[:wvu_username] = hash[:username].downcase unless hash[:username].nil?

            # find or create college
            hash[:college] = College.find_or_create_by(name: hash[:college_most_recent]) unless hash[:college_most_recent].nil?

            # find or create department
            hash[:department] = find_or_create_department(hash)

            # remove unused hash items by filtering the keys
            keys = [:role, :status, :visible, :email, :wvu_username, :first_name, :middle_name, :last_name, :research_interests, :teaching_interests, :prefix, :suffix, :college, :department, :resume]
            @faculty.assign_attributes(filter_hash_keys(hash, keys))
        end
    end
end