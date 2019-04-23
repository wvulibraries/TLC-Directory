# frozen_string_literal: true

module ImportAdapter
  class BaseAdapter
    require 'csv'

    attr_reader :import_count

    def initialize(params = {})
      @filename = params[:filename]
      @import_count = 0
    end

    def import
      CSV.foreach(@filename, headers: true, header_converters: ->(h) { h.gsub(/[^0-9A-Za-z_\s]/, '').downcase.gsub(/\s+/, '_').to_sym unless h.nil? }, liberal_parsing: true) do |row|
        if row[:username].present? 
          find_or_create_faculty(row[:username])
          # extract fields from row save them to the faculty
          process(row)
        end
      end
    end

    private

    def purge
      false
    end

    def find_or_create_faculty(username)
      # return if @faculty is set with correct faculty
      return unless @faculty.nil? || @faculty.wvu_username != username

      @faculty = Faculty.where(wvu_username: username).first_or_initialize
      # destroy saved polymorphic accociation for specified adaptor
      purge
    end

    def process(row)
      # get values from row that are common to all csv files
      # assign these to faculty
      add_faculty_fields(row)
      add_optional_items(row)
      @faculty.save(validate: false)
      @import_count += 1
    end

    # placeholder for adding additional fields
    def add_optional_items(_row)
      false
    end

    # returns hash of the default values for role status
    # and visible for a new faculty
    # @author Tracy A. McCormick
    # @return hash
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
      keys = %i[role
                status
                visible
                email
                wvu_username
                first_name
                middle_name
                last_name
                research_interests
                teaching_interests
                prefix
                suffix
                college
                department
                resume ]

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

    def add_faculty_fields(row)
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
