class Admin::OptionalItemsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:new]
  # before_action :set_email_address, only: [:show, :edit, :update, :destroy]

  # GET /optional_items
  # GET /optional_items.json
  def index; end

  # GET /optional_items/1
  # GET /optional_items/1.json
  def show
  end

  # GET /optional_items/new
  def new
    @email_address = EmailAddress.new(user: @user)
  end

  # GET /optional_items/1/edit
  def edit
  end

  # POST /optional_items
  # POST /optional_items.json
  def create
    # @user = User.find(email_address_params[:user_id])

    # optional_items_params[:user] = @user
    # @optional_items = EmailAddress.new(optional_items_params)
    # respond_to do |format|
    #   if @email_address.save
    #     format.html { redirect_to @user, notice: 'Email address was successfully created.' }
    #     format.json { render :show, status: :created, location: @email_address }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @email_address.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /optional_items/1
  # PATCH/PUT /optional_items/1.json
  def update
    # respond_to do |format|
    #   if @email_address.update(email_address_params)
    #     format.html { redirect_to @email_address, notice: 'Email address was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @email_address }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @email_address.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /optional_items/1
  # DELETE /optional_items/1.json
  def destroy
    # @email_address.destroy
    # respond_to do |format|
    #   success_str = 'Email address was successfully destroyed.'
    #   format.html { redirect_to email_addresses_url, success: success_str }
    #   format.json { head :no_content }
    # end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def find_user
      @user = User.find(params[:user_id])
    end
end
