# User Class
# ==================================================
# AUTHORS : Tracy McCormick
# Description:
class User < ApplicationRecord

  enum status: %i[active disabled]
  enum role: %i[user editor admin]
  # all the basic validations for this new record to be inserted
  validates :username, presence: true,
                       length: { within: 7..25 },
                       uniqueness: true
  validates :first_name, presence: true,
                         length: { maximum: 25 }
  validates :last_name, presence: true,
                         length: { maximum: 50 }
  validates :status, presence: true
  validates :visible, inclusion: { in: [true, false] }

  has_one :picture, as: :imageable, dependent: :destroy

  # profile
  has_one :profile, dependent: :destroy
  before_create :create_profile

  has_many :awards, dependent: :destroy
  has_many :address, dependent: :destroy
  has_many :email_address, dependent: :destroy
  has_many :phones, dependent: :destroy

  has_many :publications, dependent: :destroy
  accepts_nested_attributes_for :publications

  has_many :universities

  has_many :websites, dependent: :destroy
  accepts_nested_attributes_for :websites

  after_initialize do
    if new_record?
      # values will be available for new record forms.
      self.status ||= :disabled
      self.role ||= :user
      self.visible ||= false
    end
  end

  def isadmin?
    role == 'admin'
  end

  def haspicture?
    picture != nil
  end

  def filename
    if picture.nil?
      "No_picture_available.png"
    else
      picture.image
    end
  end

  scope :sorted, lambda { order('last_name ASC', 'first_name ASC') }
  scope :show, lambda { where(["visible = ? and status = ?", true, "active"]) }

  def name
    "#{first_name} #{last_name}"
    # Or: first_name + ' ' + last_name
    # Or: [first_name, last_name.join(' ')]
  end

  def assign_profile_params(params)
    @profile_params = params
  end

  private
  def create_profile
    build_profile(@profile_params)
  end
end
