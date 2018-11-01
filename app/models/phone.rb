# @author David J. Davis
# @data_model
# @since 0.0.1
class Phone < ApplicationRecord
  # validation
  validates :number,
            presence: true,
            length: { within: 10..30 }
  # enums types
  enum number_types: %i[phone home fax mobile]

  # associations
  belongs_to :phoneable, polymorphic: true
end
