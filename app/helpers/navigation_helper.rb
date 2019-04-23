# frozen_string_literal: true

module NavigationHelper
  def admin_links
    items = [home_link, admin_home_link, users_link, user_permissions_link]
    content_tag :ul, class: 'menu' do
      items.collect { |item| concat(content_tag(:li, item)) }
    end
  end

  def home_link
    link_to 'Home', root_path
  end

  def admin_home_link
    link_to 'Admin', admin_path
  end

  def users_link
    link_to 'Users', users_path
  end

  def user_permissions_link
    link_to 'User Permissions', user_permissions_path
  end
end
