class SearchTerm < ApplicationRecord
  # validation
  validates :term, presence: true, length: { within: 2..255 }
  validates :yearmonth, presence: true, length: { is: 6 }
  validates :term_count, presence: true, numericality: { other_than: 0 }

  after_initialize do
    self.term_count = 1
  end

  # custom methods
  def increase_count
    self.increment!(:term_count)
  end

  def human_readable_month
    Date::MONTHNAMES[yearmonth.last(2).to_i] 
  end

  def human_readable_year
    yearmonth.first(4)
  end

end
