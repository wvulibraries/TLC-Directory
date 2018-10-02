class Website < ApplicationRecord
  # associations
  belongs_to :webable, polymorphic: true

  # validation
  validates :website_url,
            presence: true,
            length: { within: 10..30 }
end
