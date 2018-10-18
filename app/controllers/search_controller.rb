class SearchController < ApplicationController
  layout 'public'
  def index
    @search_term = Sanitize.fragment params[:query]
    @results = Elasticsearch::Model.search(
      @search_term,
      [User],
      size: 1000
    ).results
  end
end