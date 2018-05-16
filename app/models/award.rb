class Award < ApplicationRecord
  belongs_to :user
  validates :starting_year, presence: true, length: { maximum: 4 }
  validates :ending_year, length: { maximum: 4 }
  validates :description, presence: true
end
