# frozen_string_literal: true

module ImportAdapter
  class PublicationAdapter < BaseAdapter
    require 'uri'

    private

    # placeholder for adding additional fields for the faculty model
    def add_optional_items(row)
      return unless row[:status] == 'Published'
      keys = %i[title status publisher pagenum issue volume]
      hash = keys.zip(row.to_hash.values_at(*keys)).to_h

      hash[:starting_year] = row[:dty_start]
      hash[:ending_year] = row[:dty_end]

      hash[:author] = build_author_list(row)

      hash[:url] = row[:web_address]
      hash[:description] = row[:abstract]

      @faculty.publications << [Publication.find_or_create_by(hash)]
    end

    def build_author_list(row)
      # Common Fields in all CSV Files that we will get and are not modifiying
      keys = %i[intellcont_auth_1_lname intellcont_auth_1_fname intellcont_auth_2_lname intellcont_auth_2_fname intellcont_auth_3_lname intellcont_auth_3_fname intellcont_auth_4_lname intellcont_auth_4_fname intellcont_auth_5_lname intellcont_auth_5_fname intellcont_auth_6_lname intellcont_auth_6_fname]
      hash = keys.zip(row.to_h.values_at(*keys)).to_h
      authors = []

      items = hash.to_a

      (0..items.count - 1).step(2) do |items_pos|
        if items[items_pos][1].present? && items[items_pos + 1][1].present?
          authors << (items[items_pos][1] + ', ' + items[items_pos + 1][1]).strip
        end
      end

      authors.to_sentence.sub('and', '&')
    end
  end
end
