# frozen_string_literal: true

# Imageable
#
# @author David J. Davis
# @concern
# @since 0.0.1
module Imageable
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, ImageUploader
  end

  # provides a boolean
  # depends on carrierwave to mount an image uploader.
  #
  # @author David J. Davis
  # @since 0.0.1
  # @return [optional, [true, false]]
  def no_image?
    image.file.nil?
  end
end
