class Directory::DepartmentsController < ApplicationController
  def list
    @departments = Department.order(:name)
  end

  def faculties
    @department = Department.find(params[:id])
    @faculties = Faculty.includes(:departments, :departmentable, :addresses, :phones)
                         .where(
                           status: 'enabled',
                           departments: { id: params[:id] }
                         )
                         .order(:last_name, :first_name)
  end

  def details
    @department = Department.find(params[:id])
  end
end