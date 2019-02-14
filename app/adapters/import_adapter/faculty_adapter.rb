module ImportAdapter  
    class FacultyAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            hash = {}
            hash[:websites] = [Website.find_or_create_by(url: row[:website])] unless row[:website].nil?            
            hash[:phones] = build_phone_array(row)
            @faculty.attributes = hash
        end

        def build_phone_array(row)
            phone_array = []
            phone = create_phone(row[:ophone1], row[:ophone2], row[:ophone3], row[:ophone4], 'office')
            phone_array << phone unless phone.nil?
            phone = create_phone(row[:dphone1],row[:dphone2], row[:dphone3], row[:dphone4], 'department')
            phone_array << phone unless phone.nil?
            phone = create_phone(row[:fax1],row[:fax2], row[:fax3], row[:fax4], 'fax')
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