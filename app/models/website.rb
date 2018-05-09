class Website < ApplicationRecord
  belongs_to :user
  validates :website_url, presence: true
end
