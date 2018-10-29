# Faculty
#
# @description: A sub class of the user model uses single table inheritance to
# determine type of profile and add extra details to user model
# @author David J. Davis, Tracy A. McCormick
# @data_model
# @since 0.0.1
class Faculty < User
  # validations
  validates :job_title,
            presence: true,
            length: { within: 2..70 }

  validates :university_classification,
            presence: true,
            length: { within: 2..70 }

  validates :description, length: { maximum: 500 }

  # associations
  has_many :departmentable, dependent: :nullify
  has_many :departments, through: :departmentable
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :phones, as: :phoneable, dependent: :destroy
  has_many :subjectables, dependent: :nullify
  has_many :subjects, through: :subjectables

  # form logic
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true

  # concerns
  include Imageable
  include Searchable

  # scopes
  scope :visible, -> { where(status: 'enabled') }
  scope :order_name, -> { order(:last_name, :first_name) }


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
  # @author David J. Davis
  # @description indexed json, this will help with search rankings.
  # rake environment elasticsearch:import:model CLASS='Employee' SCOPE="visible" FORCE=y
  def as_indexed_json(_options)
    as_json(
      methods: [:display_name],
      only: [:id, :first_name, :last_name, :preferred_name, :display_name, :description, :job_title, :university_classification, :image],
      include: {
        departments: { methods: [:building_name],
                       only: %i[name building_name] },
        subjects: { only: :name },
        phones: { only: :number }
      }
    )
  end
end