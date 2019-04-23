# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class SearchTerm < ApplicationRecord
  # validation
  validates :term, presence: true, length: { within: 2..255 }
  validates :term_count, presence: true, numericality: { other_than: 0 }

  scope :by_month, ->(month) { where('extract(month from created_at) = ?', month) }
  scope :by_year, ->(year) { where('extract(year from created_at) = ?', year) }

  def initialize(attributes = {})
    super
    self.term_count = 1
  end

  # custom methods
  def increase_count
    increment!(:term_count)
  end
end
