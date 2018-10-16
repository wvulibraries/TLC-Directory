# User Class
# ==================================================
# AUTHORS : Tracy McCormick
# Description:
class User < ApplicationRecord
  # validation
  validates :first_name, presence: true, length: { within: 2..70 }
  validates :last_name, presence: true, length: { within: 2..70 }
  validates :wvu_username, presence: true, length: { within: 7..70 }

  validates :status, presence: true
  validates :visible, inclusion: { in: [true, false] }

  # enums
  enum status: %i[active disabled]
  enum role: %i[user editor admin]

  has_one :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  before_create :create_picture

  # profile
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  before_create :create_profile

  has_many :awards, as: :awardable, dependent: :destroy
  accepts_nested_attributes_for :awards, allow_destroy: true

  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  has_many :email_addresses, as: :emailable, dependent: :destroy
  accepts_nested_attributes_for :email_addresses, allow_destroy: true

  has_many :phones, as: :phoneable, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true

  has_many :publications, as: :publishable, dependent: :destroy
  accepts_nested_attributes_for :publications, allow_destroy: true

  has_many :websites, as: :webable, dependent: :destroy
  accepts_nested_attributes_for :websites, allow_destroy: true

  has_many :enrollments
  accepts_nested_attributes_for :enrollments, allow_destroy: true
  has_many :universities, -> { distinct }, through: :enrollments
  accepts_nested_attributes_for :universities

  after_initialize do
    if new_record?
      # values will be available for new record forms.
      self.status ||= :disabled
      self.role ||= :user
      self.visible ||= false
    end
  end

  scope :show, lambda { where(["visible = ? and status = ?", true, "active"])}
  scope :sorted, lambda { order("last_name ASC", "first_name ASC") }

  # custom methods
  def display_name
    [first_name, middle_name, last_name].join(' ')
  end

  def name
    "#{first_name} #{last_name}"
    # Or: first_name + ' ' + last_name
    # Or: [first_name, last_name.join(' ')]
  end

  def assign_profile_params(params)
    @profile_params = params
  end

  def assign_picture_params(params)
    @picture_params = params
  end

  private

  def create_profile
    build_profile(@profile_params)
  end

  def create_picture
    build_picture(@picture_params)
  end

end
