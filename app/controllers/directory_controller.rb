class DirectoryController < ApplicationController
  layout 'directory'

  def index
    @faculty_profiles = Faculty.where(visible: true, status: 1).order(:last_name, :first_name)
  end

  def show
    @faculty = Faculty.where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first
  end
end
