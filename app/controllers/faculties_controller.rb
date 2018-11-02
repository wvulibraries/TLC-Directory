class FacultiesController < ApplicationController
  def list
    @faculties = Faculty.includes(:phones, :addresses)
                         .where(status: 'enabled')
                         .order(:last_name, :first_name)
  end

  def profile
    @faculty = Faculty.includes(:phones, :addresses)
                        .where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first
  end
end