class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :university
  validates_uniqueness_of :university, scope: :user
end
