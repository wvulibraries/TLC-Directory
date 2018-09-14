class Admin::UsersController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :set_user, only: %i[show edit update destroy]
  before_action :create_empty_fields, only: %i[edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @email_addresses = EmailAddress.where(user_id: @user.id)
    @addresses = Address.where(user_id: @user.id)
  end

  # GET /users/new
  def new
    @user = User.new
    @user.universities.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new user_params
    @user.assign_profile_params profile_params unless profile_params.nil?
    @user.assign_picture_params picture_params unless picture_params.nil?

    # add university from drop down to prevent duplicates we check if there is already an association
    #@user.universities << University.find(university_params[:university_id]) unless user.universities.exists?(university_params[:university_id])
    respond_to do |format|
      if @user.save
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
        format.html { redirect_to new_optional_item_path(user_id: @user.id), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.profile.update profile_params unless profile_params.nil?
    @user.picture.update picture_params unless picture_params.nil?

    # add university from drop down to prevent duplicates we check if there is already an association
    #@user.universities << University.find(university_params[:university_id]) unless @user.universities.exists?(university_params[:university_id])

    # address_params[:addresses_attributes].each do |key, item|
    #   if item['id'] == '' && item['street_address_1'] != '' && item['city'] != '' && item['state'] != '' && item['zip_code'] != ''
    #     @user.addresses.build(street_address_1: item['street_address_1'], street_address_2: item['street_address_2'], city: item['city'], state: item['state'], zip_code: item['zip_code'])
    #     @user.save
    #   elsif item['id'] != '' && item['street_address_1'] != '' && item['city'] != '' && item['state'] != '' && item['zip_code'] != ''
    #     address_object = Address.find(item['id'])
    #     if address_object.street_address_1 != item['street_address_1'] || address_object.street_address_2 != item['street_address_2'] || address_object.city != item['city'] || address_object.state != item['state'] || address_object.zip_code != item['zip_code']
    #       address_object.update(street_address_1: item['street_address_1'], street_address_2: item['street_address_2'], city: item['city'], state: item['state'], zip_code: item['zip_code'])
    #     end
    #   elsif item['id'] != '' && item['street_address_1'] == '' && item['street_address_2'] == '' && item['city'] == '' && item['state'] == '' && item['zip_code'] == ''
    #     address_object = Address.find(item['id'])
    #     address_object.destroy
    #   end
    #end

    respond_to do |format|
      if @user.update user_params
        format.html { redirect_to admin_user_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      success_str = 'User was successfully destroyed.'
      format.html { redirect_to users_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def create_empty_fields
    @user.universities.new
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:wvu_username,
                                 :last_name,
                                 :first_name,
                                 :middle_name,
                                 :status,
                                 :role,
                                 :visible)
  end

  def profile_params
    params.require(:profile).permit(:title, :department, :biography, :research_interests)
  end

  # def university_params
  #   params.require(:user).require(:universities).permit(:university_id)
  # end

  def universities_params
    params.require(:user).require(:universities).permit(:user_id, universities_attributes: %i[id name])
  end

  def picture_params
    return unless params.fetch(:user, {}).fetch(:imageable, false)
    params.require(:user).require(:imageable).permit(:image)
  end
end
