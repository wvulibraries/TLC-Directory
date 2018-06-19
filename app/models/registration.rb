# app/models/registration.rb
class Registration
  include ActiveModel::Model

  attr_accessor(
    :first_name,
    :last_name,
    :middle_name,
    
  )

  validates :first_name, presence: true
  validates :last_name, presence: true


  def register
    if valid?
      # Do something interesting here
      # - create user
      # - send notifications
      # - log events, etc.
    end
  end

  private

  def create_user
    # ...
  end
end
