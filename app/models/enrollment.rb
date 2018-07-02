class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :university
  validates_uniqueness_of :university_id, scope: :user_id
end
