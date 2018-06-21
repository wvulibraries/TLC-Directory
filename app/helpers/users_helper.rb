module UsersHelper

  def isadmin?(user)
    user.role == 'admin'
  end

  def haspicture?(user)
    user.picture != nil
  end

  def hasawards?(user)
    user.awards != nil
  end

  def hasaddresses?(user)
    user.addresses != nil
  end

  def hasemailaddresses?(user)
    user.email_addresses != nil
  end

  def hasphones?(user)
    user.phones != nil
  end

  def hasprofile?(user)
    user.profile != nil
  end

  def haspublications?(user)
    user.publications != nil
  end

  def haswebsites?(user)
    user.phones != nil
  end

  def user_photo(user)
    if user.picture.image.url.present?
      image_tag(user.picture.image.url(:medium), alt: "Profile Picture", title: "Profile Picture")
    else
      image_tag("flying-wv.jpg", height: 300, alt: "Flying WV Placeholder", title: "Missing Profile Picture")
    end
    # user.picture.image.url.present? ? image_tag(user.picture.image.url) : image_tag('flying-wv.jpg')
  end

end
