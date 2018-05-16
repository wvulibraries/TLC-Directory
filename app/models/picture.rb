class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true, optional: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates :image, presence: true
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 2.megabytes
end
