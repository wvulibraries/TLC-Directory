# app/controllers/concerns/authenticatable.rb 
module Authenticatable
  extend ActiveSupport::Concern

  # detrmine if the user can access the admin panel
  def access_permissions
    return true if authenticated? && admin?
    error_string = ''
    error_string += I18n.t('auth.invalid_access') unless authenticated?
    error_string += I18n.t('auth.invalid_permissions') unless admin?
    redirect_to root_path, error: error_string
  end

  # return unauthorized status if not authenticated
  # def authenticate!
  #   true if authenticated?
  #   render(plain: 'Unauthorized!', status: :unauthorized) unless authenticated?
  # end

  # look to see if authenticated
  def authenticated?
    session['cas'] && session['cas']['user']
  end

  # return the current signed in user
  def current_user
    User.find_by(wvu_username: session['cas']['user']) if authenticated?
  end

  # return true if admin
  def admin?
    return false if current_user.nil?
    current_user.admin?
  end

  # login methods
  def login
    if authenticated?
      redirect_to root_path, success: I18n.t('auth.success')
    else
      render(plain: 'Unauthorized!', status: :unauthorized)
    end
  end

  # signout
  def signout
    reset_session
    redirect_to logout_path
  end

  # logout
  def logout
    reset_session
    redirect_to root_path, success: I18n.t('auth.log_out')
  end
end