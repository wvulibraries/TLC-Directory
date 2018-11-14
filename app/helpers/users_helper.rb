module UsersHelper

  def isadmin?(user)
    user.role == 'admin'
  end
  
  def hasemail?(user)
    faculty.email != nil
  end
  
end
