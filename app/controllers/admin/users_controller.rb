class Admin::UsersController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:last_name)
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new user_params
    # @user.assign_profile_params profile_params unless profile_params.nil?
    @user.assign_picture_params picture_params unless picture_params.nil?

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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

    respond_to do |format|
      if @user.update user_params
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user)
          .permit(:prefix,
                  :suffix,
                  :first_name,
                  :middle_name,
                  :last_name,
                  :wvu_username,
                  :status,
                  :role,
                  :visible,
                  addresses_attributes: %i[id street_address_1 street_address_2 city state zip_code _destroy],
                  awards_attributes: %i[id starting_year ending_year description _destroy],
                  email_addresses_attributes: %i[id email_address _destroy],
                  phones_attributes: %i[id number number_types _destroy],
                  publications_attributes: %i[id description _destroy],
                  websites_attributes: %i[id url _destroy])
  end

  def profile_params
    params.require(:profile).permit(:title, :department, :biography, :research_interests)
  end

  def picture_params
    return unless params.fetch(:user, {}).fetch(:imageable, false)
    params.require(:user).require(:imageable).permit(:image)
  end
  
  def document_params
    return unless params.fetch(:user, {}).fetch(:documentable, false)
    params.require(:user).require(:documentable).permit(:document)
  end
end
