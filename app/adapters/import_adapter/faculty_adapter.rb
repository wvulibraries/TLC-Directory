# frozen_string_literal: true

module ImportAdapter
  class FacultyAdapter < BaseAdapter
    private

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      hash = {}
      hash[:biography] = row[:bio] unless row[:bio].blank?
      hash[:perferred_name] = row[:pfname] unless row[:pfname].blank?

      hash[:websites] = create_website(row[:website])

      hash[:phones] = create_phones(row)

      @faculty.attributes = hash
    end


    # returns website array
    #
    # find or create new website object Digital Measures exports
    # only contain a single website for the user. In the web interface
    # we can add multiple sites for a user.
    # returns and array that contains the website in the csv file
    # @author Tracy A. McCormick
    # @return array 
    def create_website(url)
      website_array = []

      if url.present?
        current_website = Website.find_or_initialize_by(url: url, webable: @faculty)
        current_website.save(validate: false)
        website_array << current_website
      end

      website_array
    end

    # returns phone object
    # @author Tracy A. McCormick
    # @return object   
    def create_phone(number, type)
      return unless number.present? && type.present?

      current_phone = Phone.find_or_initialize_by(number: number, number_types: type, phoneable: @faculty)
      current_phone.save(validate: false)

      current_phone
    end

    # returns phone object
    # @author Tracy A. McCormick
    # @return object
    def create_number(*args)
      # set incoming *args to required fields
      area_code, prefix, line_number, extension, type = *args
      # verify expeceted fields are not black
      return if area_code.blank? || prefix.blank? || line_number.blank? || type.blank?

      # take args and join them into a correctly formatted string
      number = [area_code, prefix, line_number].join('.')
      number << 'Ext. {extension}' unless extension.blank?

      # pass newly created string and phone type to create_phone to finish
      create_phone(number, type)
    end

    # returns array of phone numbers
    # @author Tracy A. McCormick
    # @return array
    def create_phones(row)
      phone_array = []
      phone = create_number(row[:ophone1], row[:ophone2], row[:ophone3], row[:ophone4], 'office')
      phone_array << phone unless phone.nil?
      phone = create_number(row[:dphone1], row[:dphone2], row[:dphone3], row[:dphone4], 'department')
      phone_array << phone unless phone.nil?
      phone = create_number(row[:fax1], row[:fax2], row[:fax3], row[:fax4], 'fax')
      phone_array << phone unless phone.nil?
      phone_array
    end
  end
end
