cclass SearchController < ApplicationController
  layout 'splash'
  def index
    @search_term = Sanitize.fragment params[:query]
    @results = Elasticsearch::Model.search(
      @search_term,
      [Faculty],
      size: 1000
    ).results
  end
end