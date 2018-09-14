class Phone < ApplicationRecord
  # validation
  validates :number,
            presence: true,
            length: { within: 10..30 }
  # enums types
  enum number_types: %i[phone home fax mobile]
  belongs_to :user
end
