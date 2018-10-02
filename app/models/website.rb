class Website < ApplicationRecord
  belongs_to :webable, polymorphic: true
  validates :website_url, presence: true
end
