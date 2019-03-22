# frozen_string_literal: true

module ImportAdapter
  class BaseAdapter
    require 'csv'

    attr_reader :import_count

    def initialize(params = {})
      @filename = params[:filename]
    end

    def import
      @import_count = 0
      CSV.foreach(@filename, headers: true, header_converters: ->(h) { h.gsub(/[^0-9A-Za-z_\s]/, '').downcase.gsub(/\s+/, '_').to_sym unless h.nil? }, liberal_parsing: true) do |row|
        if row[:username].present?
          # Find faculty
          @faculty = Faculty.where(wvu_username: row[:username]).first_or_initialize
          set_faculty_fields(row)
          add_optional_items(row)
          @faculty.save(validate: false)
          @import_count += 1
        end
      end
    end

    private

    # placeholder for adding additional fields
    def add_optional_items(_row)
      false
    end

    def default_faculty_values
      { role: :user, status: 'enabled', visible: true }
    end

    def find_or_create_department(hash)
      if hash[:unit_most_recent].present?
        Department.find_or_create_by(name: hash[:unit_most_recent])
      else
        Department.find_or_create_by(name: hash[:section_department_of_medicine_only_most_recent])
      end
    end

    def filter_hash_keys(hash)
      # remove unused hash items by filtering the keys
      keys = %i[role status visible email wvu_username first_name middle_name last_name research_interests teaching_interests prefix suffix college department resume]

      # return hash with only requried keys
      keys.zip(hash.values_at(*keys)).to_h
    end

    def downcase_hash_fields(hash)
      # downcase email
      hash[:email] = hash[:email].downcase unless hash[:email].nil?

      # set wvu_username & downcase
      hash[:wvu_username] = hash[:username].downcase unless hash[:username].nil?
      hash
    end

    def set_faculty_fields(row)
      # build hash values
      hash = downcase_hash_fields(row.to_hash).merge!(default_faculty_values)

      # find or create college
      hash[:college] = College.find_or_create_by(name: hash[:college_most_recent]) unless hash[:college_most_recent].nil?

      # find or create department
      hash[:department] = find_or_create_department(hash)

      @faculty.assign_attributes(filter_hash_keys(hash))
    end
  end
end
