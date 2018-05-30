class Profile < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :department, presence: true
  validates :biography, presence: true
  validates :research_interests, presence: true
end
