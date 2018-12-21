class DirectoryController < ApplicationController
  layout 'directory'

  # concerns
  include DirectorySearch

  def index
    if params[:search].nil?
      @results = Faculty.includes(:college, :department)
                        .where(visible: true, status: 'enabled')
                        .order(:last_name, :first_name)
    else
      clean_term = params[:search].gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
      @search_term = Sanitize.fragment clean_term

      @results = DirectorySearch::directory_search(@search_term, params[:college], params[:department])

      # @results = SearchService::FacultySearch.new(params).perform   

      # @results = Faculty.includes(:college, :department)
      #                   .search( 
      #                       "query": {
      #                         "query_string": {
      #                           "query": @search_term
      #                         }
      #                       },
      #                       size: 1000).records;

      # search_definition = {}

      # if params[:college].present? 
      #   college_filter = '(college_id:' + Sanitize.fragment params[:college] + ')'
      # end

      # if params[:department].present?
      #   department_filter = '(department_id:' + Sanitize.fragment params[:department] + ')'
      # end



      # search_definition[:query]  = { query_string:  { query: @search_term } }

      # if params[:college].present?
      #   search_definition[:filter]  = { term:  { college_id: params[:college] } }
      # end

      # if params[:college].present?   
      #   #search_definition[:query]  = { query_string:  { query: '(' + @search_term + ') AND (' + 'college_id:' + params[:college] + ')'} }
      # end

      # if params[:college].present? && params[:department].present? 
      #   search_definition[:query]  = { bool:{
      #    must:{
      #       query_string:{
      #          query: @search_term
      #       }
      #    },
      #    filter:{
      #       term:{ college_id: params[:college] },
      #       term:{ department_id: params[:department] }
      #    }
      #   }}
      # else
      #   search_definition[:query]  = { query_string:  { query: @search_term } }
      # end

      # search_definition[:query]  = { query_string:  { college_id: params[:college], query: @search_term } }

      # @results = Faculty.search(search_definition, size: 1000).records;
    end  
  end

  def show
    @faculty = Faculty.includes(:college, :department)
                      .where(id: params[:id], status: 'enabled')
                        .order(:last_name, :first_name)
                        .first   
  end
end
