class DirectoryController < ApplicationController
  layout 'directory'

  before_action :profile_params, only: [:show]

  def index
    @user_profiles = Faculty.all.show.sorted
  end

  def list
    @users = Faculty.where(visible: true).order(:name)
  end

  def show
    @user_profile = Faculty.find(profile_params[:user_id])
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.permit(:user_id)
    end
end
