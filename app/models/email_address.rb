class EmailAddress < ApplicationRecord
  # association
  belongs_to :emailable, polymorphic: true

  # validations
  validates :email_address, length: { within: 0..50 }
end
