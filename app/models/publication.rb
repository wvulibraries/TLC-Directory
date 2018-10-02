class Publication < ApplicationRecord
  # association
  belongs_to :publishable, polymorphic: true

  # validations
  validates :description, length: { within: 0..500 }
end
