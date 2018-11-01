module UsersHelper

  def isadmin?(user)
    user.role == 'admin'
  end

  # def haspicture?(user)
  #   user.picture != nil
  # end

  def hasawards?(user)
    user.awards.all.count != 0
  end

  def hasaddresses?(user)
    user.addresses.all.count != 0
  end

  def hasemailaddresses?(user)
    user.email_addresses.all.count != 0
  end

  def hasphones?(user)
    user.phones.all.count != 0
  end

  def hasprofile?(user)
    user.profile != nil
  end

  def haspublications?(user)
    user.publications.all.count != 0
  end

  def hasenrollments?(user)
    user.enrollments.all.count != 0
  end

  def haswebsites?(user)
    user.websites.all.count != 0
  end
  
  def hasuniversities?(user)
    user.universities.all.count != 0
  end
  
  # def hascv?(user)
  #   user.document.document_file_size != nil
  # end

end
