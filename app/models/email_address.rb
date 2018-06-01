class EmailAddress < ApplicationRecord
  belongs_to :user, optional: false
  validates :email, presence: true
end
