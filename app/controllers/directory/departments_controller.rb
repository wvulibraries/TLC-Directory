class Directory::DepartmentsController < ApplicationController
  def list
    @departments = Department.visible
                             .order(:name)
  end

  def faculties
    @department = Department.find(params[:id])
    @faculties = Faculty.includes(:college, :department, :addresses, :phones)
                        .where(
                           status: 'enabled',
                           department: params[:id]
                        )
                        .order(:last_name, :first_name)
  end

  def details
    @department = Department.find(params[:id])
  end
end