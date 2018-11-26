class SearchController < ApplicationController
  # layout 'splash'
  def index
    @search_term = Sanitize.fragment params[:search]
    @results = Elasticsearch::Model.search(
      @search_term,
      [College, Faculty],
      size: 1000
    ).results
  end
end