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
    return_string = display_date || ""
    if name.present? && organization.present?
      return_string << "#{name}" 
      return_string << ", #{organization}" if organization.present?
    elsif name.present? && organization.nil?
      return_string << "#{name}" 
    elsif name.nil? && organization.present? 
      return_string << "#{organization}" 
    end
  end

  def display_date
    if starting_year.to_s.length == 4 && ending_year.to_s.length == 4
      "#{starting_year} - #{ending_year} "
    elsif starting_year.to_s.length == 4
      "#{starting_year} "
    end
  end
end
