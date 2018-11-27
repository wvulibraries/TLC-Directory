class DirectoryController < ApplicationController
  layout 'directory'

  def index
    if params[:search].nil?
      @faculty_profiles = Faculty.includes(:phones, :addresses)
                                 .where(visible: true, status: 1)
                                 .order(:last_name, :first_name)
    else
      clean_term = params[:search].gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
      @search_term = Sanitize.fragment clean_term
      @faculty_profiles = Elasticsearch::Model.search(
        @search_term,
        [Faculty],
        size: 1000
      ).results
    end  
  end

  def show
    @faculty = Faculty.includes(:phones, :addresses)
                      .where(visible: true, status: 1)
                      .first
  end
end
