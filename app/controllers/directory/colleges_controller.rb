class Directory::CollegesController < ApplicationController
  def list
    @colleges = College.visible
                       .order(:name)
  end

  def faculties
    @college = College.find(params[:id])
    @faculties = Faculty.includes(:college, :department, :addresses, :phones)
                         .where(
                           status: 'enabled',
                           college: params[:id]
                         )
                         .order(:last_name, :first_name)
  end

  def details
    @college = College.find(params[:id])
  end
end