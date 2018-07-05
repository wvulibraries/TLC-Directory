class University < ApplicationRecord
  validates :name, presence: true

  has_many :enrollments
  has_many :users, -> { distinct }, through: :enrollments

  def as_json
    {
      id: id,
      text: name
    }
  end
end
