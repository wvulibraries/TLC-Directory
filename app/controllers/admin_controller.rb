# admin controller
class AdminController < ApplicationController
  layout 'admin'
  # run a filter with authenticatable concern
  # before_action :access_permissions unless Rails.env.test?
end
