# frozen_string_literal: true

class Admin::SearchstatsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  # service modules
  include SearchService

  def index
    stats = SearchService::ViewStats.new(params)
    @searchterms = stats.perform
    flash.now[:error] = stats.error if stats.error
  end
end
