class Phone < ApplicationRecord
  # associations
  belongs_to :phoneable, polymorphic: true

  # validation
  validates :number,
            presence: true,
            length: { within: 10..30 }

  # enums types
  enum number_types: %i[fax home mobile office]
end
