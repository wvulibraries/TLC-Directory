module UsersHelper

  def isadmin?(user)
    user.role == 'admin'
  end

end
