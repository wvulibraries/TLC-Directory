# Address Active Record Object for storing addresses
#
# @author David J. Davis
# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Address < ApplicationRecord
  # association
  belongs_to :addressable, polymorphic: true

  # validations
  validates :street_address_1, length: { within: 0..50 }
  validates :street_address_2, length: { within: 0..50 }
  validates :city, length: { within: 0..60 }
  validates :state, length: { within: 0..50 }
  validates :zip_code, length: { within: 0..20 }

  # human_readable
  def human_readable
    "#{street_address_1} #{street_address_2}, #{city}, #{state} #{zip_code}"
  end
end
