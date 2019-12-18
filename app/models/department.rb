# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Department < ApplicationRecord
  # validation
  validates :name,
            presence: true,
            length: { within: 5..50 },
            uniqueness: { case_sensitive: false }

  has_many :faculties, -> { order(:last_name, :first_name) }

  # active status
  enum status: %i[enabled disabled]

  # search
  include Searchable

  # scopes
  scope :visible, -> { where(status: 'enabled') }
  scope :order_name, -> { order(:name) }

  # Elastic Search Index settings.
  # These are set in the model to index only specific information.   
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: :text
    end
  end

  # Elastic Search Settings
  # @author Tracy A. McCormick
  # @description
  # indexed json, this will help with search rankings.
  # rake environment elasticsearch:import:model CLASS='Department' SCOPE="visible" FORCE=y
  def as_indexed_json(_options)
    as_json(
      only: %i[id name],
      include: {
        faculties: { only: :name }
      }
    )
  end
end
