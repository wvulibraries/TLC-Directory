# frozen_string_literal: true

module ImportAdapter
  class AdminAdapter < BaseAdapter
    private

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      hash = {}
      hash[:title] = row[:rank] unless row[:rank].nil?

      @faculty.assign_attributes(hash)
    end
  end
end
