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
      @results = Faculty.search( 
        "query": {
          "query_string": {
            "query": @search_term
          }
        },
        size: 1000);
    end  
  end

  def show
    @faculty = Faculty.includes(:phones, :addresses)
                        .where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first   
  end
end
