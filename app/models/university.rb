class University < ApplicationRecord
  validates :name, presence: true

  has_many :enrollments
  has_many :users, -> { distinct }, through: :enrollments
end
