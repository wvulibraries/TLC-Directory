# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Award < ApplicationRecord
  # association
  belongs_to :awardable, polymorphic: true

  # validations
  validates :starting_year, :ending_year, length: { is: 4 }, allow_blank: true
  validates :description, length: { within: 0..500 }

  # display publication
  def display_award
    return_string = "#{starting_year}" if starting_year.to_s.length == 4
    return_string += ' - ' + "#{ending_year}" if ending_year.to_s.length == 4
    return_string += ' - ' + "#{name}" if name.to_s.length > 0
    return_string += ' - ' + "#{organization}" if organization.to_s.length > 0
    return_string += ' - ' + "#{description}" if description.to_s.length > 0
  end
end
