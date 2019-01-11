class Admin::SearchstatsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  def index
    @searchterms = SearchTerm.order(:yearmonth, :term)
  end
end
