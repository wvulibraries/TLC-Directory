class Admin::AddressesController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:new]
  before_action :set_address, only: %i[show edit update destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show; end

  # GET /addresses/new
  def new
    @address = Address.new(user: @user)
  end

  # GET /addresses/1/edit
  def edit; end

  # POST /addresses
  # POST /addresses.json
  def create
    user_object = User.find(address_params[:user_id])
    address_params[:user] = user_object
    @address = Address.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      success_str = 'Address was successfully destroyed.'
      format.html { redirect_to addresses_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_user
    @user = User.find(params[:user_id])
  end

  def set_address
    @address = Address.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def address_params
    params.require(:address).permit(:user_id,
                                    :street_address_1,
                                    :street_address_2,
                                    :city,
                                    :state,
                                    :zip_code)
  end
end
