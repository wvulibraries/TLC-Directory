# @author David J. Davis
# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Phone < ApplicationRecord
  # validation
  validates :number,
            presence: true,
            length: { within: 10..30 }
  # enums types
  enum number_types: %i[phone home fax mobile office department]

  # associations
  belongs_to :phoneable, polymorphic: true

  def type
    number_types.sub(/\S/, &:upcase)
  end
end
