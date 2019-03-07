# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Publication < ApplicationRecord
  # association
  belongs_to :publishable, polymorphic: true

  # validations
  validates :starting_year, :ending_year, length: { is: 4 }, allow_blank: true
  #validates :url, presence: false, url: true 

  # display publication
  def display_date
    if starting_year.to_s.length == 4 && ending_year.to_s.length == 4
      return_string = "(" + "#{starting_year}" + " - " + "#{ending_year}" + ")."
    elsif starting_year.to_s.length == 4
      return_string = "(" + "#{starting_year}" + ")."
    elsif ending_year.to_s.length == 4
      return_string = "(" + "#{ending_year}" + ")."
    end
  end
end
