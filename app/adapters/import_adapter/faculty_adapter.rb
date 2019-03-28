# frozen_string_literal: true

module ImportAdapter
  class FacultyAdapter < BaseAdapter
    private

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      hash = {}
      hash[:biography] = row[:bio] unless row[:bio].nil?
      hash[:perferred_name] = row[:pfname] unless row[:pfname].nil?
      hash[:websites] = [Website.find_or_create_by(url: row[:website])] unless row[:website].nil?
      hash[:phones] = build_phone_array(row)
      @faculty.attributes = hash
    end

    def create_phone(number, type)
      return unless number.present? && type.present?

      Phone.find_or_create_by(number: number, number_types: type)
    end

    def create_number(area_code, prefix, line_number, extension)
      return unless area_code.present? && prefix.present? && line_number.present?

      number = area_code + '.' + prefix + '.' + line_number
      return number unless extension.present?

      # add extension and return
      number + 'Ext. ' + extension
    end

    def create_office_phone(row)
      number = create_number(row[:ophone1], row[:ophone2], row[:ophone3], row[:ophone4])
      create_phone(number, 'office')
    end

    def create_department_phone(row)
      number = create_number(row[:dphone1], row[:dphone2], row[:dphone3], row[:dphone4])
      create_phone(number, 'department')
    end

    def create_fax_phone(row)
      number = create_number(row[:fax1], row[:fax2], row[:fax3], row[:fax4])
      create_phone(number, 'department')
    end

    def build_phone_array(row)
      phone_array = []
      phone = create_office_phone(row)
      phone_array << phone unless phone.nil?
      phone = create_department_phone(row)
      phone_array << phone unless phone.nil?
      phone = create_fax_phone(row)
      phone_array << phone unless phone.nil?
      phone_array
    end
  end
end
