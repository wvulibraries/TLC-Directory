# frozen_string_literal: true

module ImportAdapter
  class AdminPermAdapter < BaseAdapter
    private

      # placeholder for adding additional fields for the faculty model
      def add_optional_items(row)
        hash = {}
        hash[:title] = row[:srank] unless row[:srank].nil?

        @faculty.assign_attributes(hash)
      end
  end
end
