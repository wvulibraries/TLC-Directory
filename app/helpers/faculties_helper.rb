module FacultiesHelper

  def isadmin?(faculty)
    faculty.role == 'admin'
  end

  # def haspicture?(faculty)
  #   faculty.picture != nil
  # end

  def hasawards?(faculty)
    faculty.awards.all.count != 0
  end

  def hasaddresses?(faculty)
    faculty.addresses.all.count != 0
  end

  def hasemailaddresses?(faculty)
    faculty.email != nil
  end

  def hasphones?(faculty)
    faculty.phones.all.count != 0
  end

  def haspublications?(faculty)
    faculty.publications.all.count != 0
  end

  def hasenrollments?(faculty)
    faculty.enrollments.all.count != 0
  end

  def haswebsites?(faculty)
    faculty.websites.all.count != 0
  end
  
  def hasuniversities?(faculty)
    faculty.universities.all.count != 0
  end
  
  # def hascv?(faculty)
  #   faculty.document.document_file_size != nil
  # end

end
