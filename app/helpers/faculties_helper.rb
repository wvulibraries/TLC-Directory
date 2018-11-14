module FacultiesHelper

  def isadmin?(faculty)
    faculty.role == 'admin'
  end

  def hasimage?(faculty)
    faculty.image != nil
  end

  def hasawards?(faculty)
    faculty.awards.all.count != 0
  end

  def hasaddresses?(faculty)
    faculty.addresses.all.count != 0
  end

  def hasphones?(faculty)
    faculty.phones.all.count != 0
  end

  def haspublications?(faculty)
    faculty.publications.all.count != 0
  end

  def haswebsites?(faculty)
    faculty.websites.all.count != 0
  end
  
  def hascv?(faculty)
    faculty.resume != nil
  end

end
