class Award < ApplicationRecord
  # association
  belongs_to :awardable, polymorphic: true

  # validations
  validates :starting_year, :ending_year, length: { is: 4 }, allow_blank: true
  validates :description, length: { within: 0..500 }

  # human_readable
  def human_readable
    if starting_year.to_s.length == 4 && ending_year.to_s.length == 4
      "#{starting_year} - #{ending_year} #{description}"
    elsif starting_year.to_s.length == 4
      "#{starting_year} #{description}"
    else
      description
    end
  end
end
