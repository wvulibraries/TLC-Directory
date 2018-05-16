class EmailAddress < ApplicationRecord
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9,-]+\.[a-z]{2,4}\Z/i
  belongs_to :user
  validates :email, presence: true,
                  length: { maximum: 100 },
                  format: EMAIL_REGEX,
                  confirmation: true
end
