class DirectoryController < ApplicationController
  layout 'directory'

  def index
    @search_term = Sanitize.fragment params[:search]
    
    if params[:search].nil?
      @faculty_profiles = Faculty.where(visible: true, status: 1).order(:last_name, :first_name)
    else
      @faculty_profiles = Elasticsearch::Model.search(
        @search_term,
        [Faculty],
        size: 1000
      ).results
    end  
  end

  def show
    @faculty = Faculty.where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first
  end
end
