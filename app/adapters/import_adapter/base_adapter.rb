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
            # convert row to hash
            hash = row.to_hash

            # add default values
            hash[:role] = :user
            hash[:status] = 'enabled'
            hash[:visible] = true

            # downcase email
            hash[:email] = hash[:email].downcase unless hash[:email].nil?

            # set wvu_username & downcase
            hash[:wvu_username] = hash[:username].downcase unless hash[:username].nil?
            #hash = rename_hash_key(hash, :username, :wvu_username)

            # find or create college
            hash[:college] = College.find_or_create_by(name: hash[:college_most_recent]) unless hash[:college_most_recent].nil?

            # find or create department
            hash[:department] = find_or_create_department(hash)

            # find or create optional items
            @faculty.attributes = filter_hash_keys(hash)
        end

        def find_or_create_department(hash)
            Department.find_or_create_by(name: hash[:unit_most_recent]) || Department.find_or_create_by(name: hash[:section_department_of_medicine_only_most_recent])
        end
        
        def rename_hash_key(hash, source, dest)
            hash[dest] = hash[source]
            hash.delete(source) 
            hash
        end

        def filter_hash_keys(hash)
            # return hash with only requried keys
            keys = [:role, :status, :visible, :first_name, :middle_name, :last_name, :research_interests, :teaching_interests, :prefix, :suffix, :college, :department, :wvu_username, :resume, :email]
            keys.zip(hash.values_at *keys).to_h           
        end
    end
end