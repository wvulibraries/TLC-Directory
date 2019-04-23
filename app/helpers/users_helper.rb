# frozen_string_literal: true

module UsersHelper
  def isadmin?(user)
    user.role == 'admin'
  end

  def hasemail?(user)
    user.email != nil
  end

  def hasusername?(user)
    user.wvu_username != nil
  end
end
