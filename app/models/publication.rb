# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Publication < ApplicationRecord
  # association
  belongs_to :publishable, polymorphic: true
end
