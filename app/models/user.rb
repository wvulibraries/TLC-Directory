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
  accepts_nested_attributes_for :picture
  before_create :create_picture

  # profile
  has_one :profile, dependent: :destroy
  before_create :create_profile

  has_many :awards, dependent: :destroy
  accepts_nested_attributes_for :awards

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  has_many :email_addresses, dependent: :destroy
  accepts_nested_attributes_for :email_addresses

  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones

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

  def assign_picture_params(params)
    puts "assign picture params"
    puts params
    @picture_params = params
  end

  private
  def create_profile
    build_profile(@profile_params)
  end

  def create_picture
    puts @picture_params
    build_picture(@picture_params)
  end
end
