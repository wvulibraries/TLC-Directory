# frozen_string_literal: true

module ImportAdapter
  class FacultyAdapter < BaseAdapter
    private

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      hash = {}
      hash[:biography] = row[:bio] unless row[:bio].nil?
      hash[:perferred_name] = row[:pfname] unless row[:pfname].nil?
      hash[:websites] = create_website(row[:website])
      hash[:phones] = build_phone_array(row)
      @faculty.attributes = hash
    end

    def create_website(url)
      return [] unless url.present?

      [Website.find_or_create_by(url: url)]
    end

    def create_phone(number, type)
      return unless number.present? && type.present?

      Phone.find_or_create_by(number: number, number_types: type)
    end

    def create_number(hash)
      return unless valid_number_hash?(hash)

      number = hash[:area_code] + '.' + hash[:prefix] + '.' + hash[:line_number]
      return number unless hash[:extension].present?

      # add extension and return
      number + 'Ext. ' + hash[:extension]
    end

    def valid_number_hash?(hash)
      hash[:area_code].present? && hash[:prefix].present? && hash[:line_number].present?
    end

    def create_office_phone(row)
      hash = {}
      hash[:area_code] = row[:ophone1]
      hash[:prefix] = row[:ophone2]
      hash[:line_number] = row[:ophone3]
      hash[:extension] = row[:ophone4]

      number = create_number(hash)
      create_phone(number, 'office')
    end

    def create_department_phone(row)
      hash = {}
      hash[:area_code] = row[:dphone1]
      hash[:prefix] = row[:dphone2]
      hash[:line_number] = row[:dphone3]
      hash[:extension] = row[:dphone4]

      number = create_number(hash)
      create_phone(number, 'department')
    end

    def create_fax_phone(row)
      hash = {}
      hash[:area_code] = row[:fax1]
      hash[:prefix] = row[:fax2]
      hash[:line_number] = row[:fax3]
      hash[:extension] = row[:fax4]

      number = create_number(hash)
      create_phone(number, 'fax')
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
