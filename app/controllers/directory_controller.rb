class DirectoryController < ApplicationController
  layout 'directory'

  # service modules
  include SearchService

  def index
    SearchService::SearchStats.new(params)
    @results = SearchService::FacultySearch.new(params).perform
  end

  def show
    @faculty = Faculty.includes(:college, :department)
                      .where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first   
  end
end
