# app/controllers/registration_controller.rb
class RegistrationsController < ApplicationController
  respond_to :html

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    @registration.register

    respond_with @registration, location: some_success_path
  end

  private

  def registration_params
    # ...
  end
end
