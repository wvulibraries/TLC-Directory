class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_attached_file :image,
  :styles => {
    :thumb => "100x100#",
    :small  => "150x150>",
    :medium => "200x200" },
    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
    url: "/system/:attachment/:id/:style/:filename"

  validates_attachment  :image, :presence => true,
                    :content_type => { :content_type => %w(image/jpeg image/jpg image/png) },
                    :size => { :in => 0..1.megabytes }
end
