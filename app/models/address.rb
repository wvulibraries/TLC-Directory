# Building Active Record Object for storing the directories buildings
#
# @author David J. Davis
# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Address < ApplicationRecord
  # association
  belongs_to :user

  # validations
  validates :street_address_1, length: { within: 0..50 }
  validates :street_address_2, length: { within: 0..50 }
  validates :city, length: { within: 0..60 }
  validates :state, length: { within: 0..50 }
  validates :zip_code, length: { within: 0..20 }

  # human_readable
  def human_readable
    "#{line1} #{line2}, #{city}, #{state} #{zip}"
  end
end
