class DirectoryController < ApplicationController
  layout 'public'

  def index
    @user_profiles = User.all.show
  end

end
