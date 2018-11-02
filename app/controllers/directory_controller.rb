class DirectoryController < ApplicationController
  layout 'directory'

  before_action :profile_params, only: [:show]

  def index
    @faculty_profiles = Faculty.all.show.sorted
  end

  def list
    @faculties = Faculty.where(visible: true).order(:name)
  end

  def show
    @faculty_profile = Faculty.find(profile_params[:faculty_id])
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.permit(:faculty_id)
    end
end
