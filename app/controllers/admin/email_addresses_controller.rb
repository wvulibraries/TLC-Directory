class Admin::EmailAddressesController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:new]
  before_action :set_email_address, only: [:show, :edit, :update, :destroy]

  # GET /email_addresses
  # GET /email_addresses.json
  def index
    @email_addresses = EmailAddress.all
  end

  # GET /email_addresses/1
  # GET /email_addresses/1.json
  def show
  end

  # GET /email_addresses/new
  def new
    @email_address = EmailAddress.new(user: @user)
  end

  # GET /email_addresses/1/edit
  def edit
  end

  # POST /email_addresses
  # POST /email_addresses.json
  def create
    user_object = User.find(email_address_params[:user_id])
    email_address_params[:user] = user_object
    @email_address = EmailAddress.new(email_address_params)
    respond_to do |format|
      if @email_address.save
        format.html { redirect_to @email_address, notice: 'Email address was successfully created.' }
        format.json { render :show, status: :created, location: @email_address }
      else
        format.html { render :new }
        format.json { render json: @email_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_addresses/1
  # PATCH/PUT /email_addresses/1.json
  def update
    respond_to do |format|
      if @email_address.update(email_address_params)
        format.html { redirect_to @email_address, notice: 'Email address was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_address }
      else
        format.html { render :edit }
        format.json { render json: @email_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_addresses/1
  # DELETE /email_addresses/1.json
  def destroy
    @email_address.destroy
    respond_to do |format|
      success_str = 'Email address was successfully destroyed.'
      format.html { redirect_to email_addresses_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_user
      @user = User.find(params[:user_id])
    end

    def set_email_address
      @email_address = EmailAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_address_params
      params.require(:email_address).permit(:user_id, :email)
    end
end
