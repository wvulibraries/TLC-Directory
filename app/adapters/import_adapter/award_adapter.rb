# frozen_string_literal: true

module ImportAdapter
  class AwardAdapter < BaseAdapter
    private

    def purge
      # clear current awards list for faculty
      # will be reloaded from csv import
      @faculty.awards.each(&:destroy)
    end

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      hash = {}
      hash[:starting_year] = row[:dty_start]
      hash[:ending_year] = row[:dty_end]
      hash[:name] = row[:name]
      hash[:organization] = row[:org]
      hash[:description] = row[:desc]

      @faculty.awards << [Award.find_or_create_by(hash)]
    end
  end
end
