class Directory::CollegesController < ApplicationController
  def list
    @colleges = College.order(:name)
  end

  def faculties
    @college = College.find(params[:id])
    @faculties = Faculty.includes(:colleges, :collegeable, :addresses, :phones)
                         .where(
                           status: 'enabled',
                           colleges: { id: params[:id] }
                         )
                         .order(:last_name, :first_name)
  end

  def details
    @college = College.find(params[:id])
  end
end