class Admin::ResearchInterestsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:new]
  before_action :set_research_interest, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @researchinterests = ResearchInterest.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @researchinterest = ResearchInterest.new(user: @user)
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    user_object = User.find(researchinterest_params[:user_id])
    researchinterest_params[:user] = user_object
    @researchinterest = ResearchInterest.new(researchinterest_params)
    respond_to do |format|
      if @researchinterest.save
        format.html { redirect_to @researchinterest, notice: 'Research Interest was successfully created.' }
        format.json { render :show, status: :created, location: @researchinterest }
      else
        format.html { render :new }
        format.json { render json: @researchinterest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @researchinterest.update(researchinterest_params)
        format.html { redirect_to @researchinterest, notice: 'Research Interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @researchinterest }
      else
        format.html { render :edit }
        format.json { render json: @researchinterest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @researchinterest.destroy
    respond_to do |format|
      success_str = 'Research Interest was successfully destroyed.'
      format.html { redirect_to profiles_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_user
      @user = User.find(params[:user_id])
    end

    def set_research_interest
      @researchinterest = ResearchInterest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def researchinterest_params
      params.require(:profile).permit(:user_id, :description)
    end
end
