# Faculty
#
# @description: A sub class of the user model uses single table inheritance to
# determine type of profile and add extra details to user model
# @author David J. Davis
# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class Faculty < User
  self.table_name = :faculty
  
  # validations
  validates :title,
            presence: true,
            length: { within: 2..70 }
            
  validates :biography, 
            presence: true 
                  
  validates :research_interests, 
            presence: true

  belongs_to :college
  belongs_to :department
            
  # associations
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :awards, as: :awardable, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :publications, as: :publishable, dependent: :destroy
  has_many :websites, as: :webable, dependent: :destroy

  # form logic
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :awards, allow_destroy: true  
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :publications, allow_destroy: true
  accepts_nested_attributes_for :websites, allow_destroy: true
  accepts_nested_attributes_for :college
  accepts_nested_attributes_for :department

  # concerns
  include Imageable
  include Searchable

  # scopes
  # scope :visible, -> { where(status: 'enabled') }
  # scope :order_name, -> { order(:last_name, :first_name) }

  # Resume / CV Option
  mount_uploader :resume, ResumeUploader

  # resume?
  # -----------------------------------------------------
  # @author David J. Davis
  # @description looks to see if the user has a resume or cv attached
  # will return true if there is a file, false if no file
  # @return boolean
  def resume?
    !resume.file.nil?
  end

  # Elastic Search Settings
  # -----------------------------------------------------
  # @author David J. Davis, Tracy A. McCormick
  # @description indexed json, this will help with search rankings.
  # rake environment elasticsearch:import:model CLASS='Faculty' SCOPE="visible" FORCE=y
  def as_indexed_json(_options)
    as_json(
      methods: [:display_name],
      only: [:id, :first_name, :last_name, :preferred_name, :display_name, :title, :research_interests, :biography, :image],
      include: {
        college: { only: %i[id name] },
        department: { only: %i[id name] },
      }
    )
  end
end