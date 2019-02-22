# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Publication < ApplicationRecord
  # association
  belongs_to :publishable, polymorphic: true

  # validations
  validates :starting_year, :ending_year, length: { is: 4 }, allow_blank: true

  # display publication
  def display_date
    if starting_year.to_s.length == 4 && ending_year.to_s.length == 4
      return_string = "(" + "#{starting_year}" + " - " + "#{ending_year}" + ")."
    else
      return_string = "(" + "#{starting_year}" + ")." if starting_year.to_s.length == 4
    end
  end

  def retrieved_from
    "Retrieved from " + "#{url}" if url.present?
  end
end
