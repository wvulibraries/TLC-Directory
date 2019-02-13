module ImportAdapter  
    class FacultyAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            hash = {}
            hash[:websites] = [Website.find_or_create_by(url: row["WEBSITE"])] unless row["WEBSITE"].nil?            
            hash[:phones] = build_phone_array(row)
            @faculty.attributes = hash
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