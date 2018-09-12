# app/models/concerns/optional_items_concern
module OptionalItemsConcern
  extend ActiveSupport::Concern

  def valid_address_id(id)
    address_object = Address.find(item['id']) if id != ''
    !address_object.nil?
  end

  def blank_address?(item)
    # return true if all address fields are blank
    item['street_address_1'] == '' && item['street_address_2'] == '' && item['city'] == '' && item['state'] == '' && item['zip_code'] == ''
  end

  def create_new_address(user_id, item)
    @user = User.find(user_id)
    @user.addresses.build(street_address_1: item['street_address_1'],
                          street_address_2: item['street_address_2'],
                          city: item['city'],
                          state: item['state'],
                          zip_code: item['zip_code'])
    @user.save
  end

  def update_address(item)
    address_object = Address.find(item['id'])
    address_object.update(street_address_1: item['street_address_1'],
                          street_address_2: item['street_address_2'],
                          city: item['city'],
                          state: item['state'],
                          zip_code: item['zip_code'])
  end

  def update_or_destroy(item)
    if blank_address?(item['id'])
      address_object.destroy
    else
      update_address(item)
    end
  end

  def process_address(user_id, item)
    # if blank fields and valid id destroy record
    if valid_address_id(item['id'])
      update_or_destroy(item)
    elsif !blank_address?(item)
      create_new_address(user_id, item)
    end
  end

  def process_description(user_id, item)
    @user = User.find(user_id)

    if item['id'] == '' && item['description'] != ''
      @user.awards.build(description: item['description'])
      @user.save
    elsif item['id'] != '' && item['description'] != ''
      award_object = Award.find(item['id'])
      if award_object.description != item['description']
        award_object.update(description: item['description'])
      end
    elsif item['id'] != '' && item['description'] == ''
      award_object = Award.find(item['id'])
      award_object.destroy
    end
  end

  def process_email_address(user_id, item)
    @user = User.find(user_id)

    if item['id'] == '' && item['email'] != ''
      @user.email_addresses.build(email: item['email'])
      @user.save
    elsif item['id'] != '' && item['email'] != ''
      email_object = EmailAddress.find(item['id'])
      if email_object.email != item['email']
        email_object.update(email: item['email'])
      end
    elsif item['id'] != '' && item['email'] == ''
      email_object = EmailAddress.find(item['id'])
      email_object.destroy
    end
  end

  def process_phone(user_id, item)
    @user = User.find(user_id)

    if item['id'] == '' && item['phone_number'] != '' && item['type'] != ''
      @user.phones.build(phone_number: item['phone_number'], phone_type: item['phone_type'])
      @user.save
    elsif item['id'] != '' && item['phone_number'] != '' && item['phone_type'] != ''
      phone_object = Phone.find(item['id'])
      if phone_object.phone_number != item['phone_number'] || phone_object.phone_type != item['phone_type']
        phone_object.update(phone_number: item['phone_number'], phone_type: item['phone_type'])
      end
    elsif item['id'] != '' && item['phone_number'] == '' && item['phone_type'] == ''
      phone_object = Phone.find(item['id'])
      phone_object.destroy
    end
  end

  def process_publication(user_id, item)
    @user = User.find(user_id)

    if item['id'] == '' && item['description'] != ''
      @user.publications.build(description: item['description'])
      @user.save
    elsif item['id'] != '' && item['description'] != ''
      publication_object = Publication.find(item['id'])
      if publication_object.description != item['description']
        publication_object.update(description: item['description'])
      end
    elsif item['id'] != '' && item['description'] == ''
      publication_object = Publication.find(item['id'])
      publication_object.destroy
    end
  end

  def process_website(user_id, item)
    @user = User.find(user_id)

    if item['id'] == '' && item['website_url'] != ''
      @user.websites.build(website_url: item['website_url'])
      @user.save
    elsif item['id'] != '' && item['website_url'] != ''
      website_object = Website.find(item['id'])
      if website_object.website_url != item['website_url']
        website_object.update(website_url: item['website_url'])
      end
    elsif item['id'] != '' && item['website_url'] == ''
      website_object = Website.find(item['id'])
      website_object.destroy
    end
  end

end
