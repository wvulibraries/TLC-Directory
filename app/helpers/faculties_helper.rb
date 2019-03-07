module FacultiesHelper
  require 'uri'

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

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
  end

end
