class CollegesController < ApplicationController
  def list
    @colleges = College.where(status: 'enabled')
                       .order(:name)
  end

  def faculties
    @faculties = Faculty.includes(:departments, :departmentable, :addresses, :phones)
                         .where(status: 'enabled', departments: { college_id: params[:id] })
                         .order(:last_name, :first_name)
    @college = College.find(params[:id])
  end

  def details
    @college = College.find(params[:id])
  end
end
