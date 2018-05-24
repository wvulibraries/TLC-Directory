class DirectoryController < ApplicationController
  layout 'public'

  def index
    @profiles = User.all.show
  end

end
