# User Class
# ==================================================
# AUTHORS : Tracy McCormick
# Description:
class User < ApplicationRecord
  enum status: %i[disabled active]
  enum role: %i[user editor admin]
  # all the basic validations for this new record to be inserted
  validates :username, presence: true
  validates :full_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, presence: true
  validates :visible, :inclusion => { :in => [true, false] }

  has_one :profile
  has_many :email_address
  has_many :phone
  has_many :address
  has_many :universities
  has_many :websites

  after_initialize :set_default_status, :set_default_role, :set_default_visibility, :if => :new_record?

  def set_default_status
    self.status ||= :disabled
  end

  def set_default_role
    self.role ||= :user
  end

  def set_default_visibility
    self.visible ||= false
  end

  def isadmin?
    self.role == 'admin'
  end

  # def can_manage_profile(:profile)
  #   isAdmin
  # end
end
