class Admin::ProfilesController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:new]
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /biographies
  # GET /biographies.json
  def index
    @profiles = Profile.all
  end

  # GET /biographies/1
  # GET /biographies/1.json
  def show
  end

  # GET /biographies/new
  def new
    @profile = Profile.new(user: @user)
  end

  # GET /biographies/1/edit
  def edit
  end

  # POST /biographies
  # POST /biographies.json
  def create
    user_object = User.find(profile_params[:user_id])
    profile_params[:user] = user_object
    @profile = Profile.new(profile_params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /biographies/1
  # PATCH/PUT /biographies/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /biographies/1
  # DELETE /biographies/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      success_str = 'Profile was successfully destroyed.'
      format.html { redirect_to biographies_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_user
      @user = User.find(params[:user_id])
    end

    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id,
                                      :title,
                                      :department,
                                      :biography,
                                      :research_interests)
    end
end
