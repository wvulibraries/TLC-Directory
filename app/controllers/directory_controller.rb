class DirectoryController < ApplicationController
  layout 'directory'

  def index
    if params[:search].nil?
      @results = Faculty.includes(:phones, :addresses)
                                 .where(visible: true, status: 'enabled')
                                 .order(:last_name, :first_name)
    else
      clean_term = params[:search].gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
      @search_term = Sanitize.fragment clean_term
      @results = Elasticsearch::Model.search(
        @search_term,
        [Faculty],
        size: 1000
      ).results
    end  
  end

  def show
    @faculty = Faculty.includes(:phones, :addresses)
                        .where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first   
  end
end
