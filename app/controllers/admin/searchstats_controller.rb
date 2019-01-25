class Admin::SearchstatsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  # service modules
  include SearchService

  def index
    @searchterms = SearchService::ViewStats.new(params).perform
  end

  def show

  end
end
