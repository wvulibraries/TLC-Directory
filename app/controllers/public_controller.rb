class PublicController < ApplicationController
  layout 'public'

  def index; end

  def logout
    # CASClient::Frameworks::Rails::Filter.logout(self)
    session.delete('cas')
    redirect_to root_path, notice: 'Logged Out!'
  end

end
