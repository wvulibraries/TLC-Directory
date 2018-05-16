# User Class
# ==================================================
# AUTHORS : Tracy McCormick
# Description:
class User < ApplicationRecord
  enum status: %i[disabled active]
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
  has_one :profile, dependent: :destroy
  has_many :email_address, dependent: :destroy
  has_many :phone, dependent: :destroy
  has_many :address, dependent: :destroy
  has_many :universities
  has_many :websites, dependent: :destroy
  has_many :awards, dependent: :destroy

  after_initialize do
    if self.new_record?
      # values will be available for new record forms.
      self.status ||= :disabled
      self.role ||= :user
      self.visible ||= false
    end
  end

  def isadmin?
    self.role == 'admin'
  end

  def haspicture?
    picture != nil
  end

  # def can_manage_profile(:profile)
  #   isAdmin
  # end

  scope :sorted, lambda { order('last_name ASC', 'first_name ASC') }

  def name
    "#{first_name} #{last_name}"
    # Or: first_name + ' ' + last_name
    # Or: [first_name, last_name.join(' ')]
  end

end
