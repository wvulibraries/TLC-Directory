class Website < ApplicationRecord
  # associations
  belongs_to :webable, polymorphic: true

  # validations
  validates :url, presence: true, url: true
end
