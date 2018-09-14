class Admin::PublicationsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:new]
  before_action :set_publication, only: %i[show edit update destroy]

  # GET /biographies
  # GET /biographies.json
  def index
    @publications = Publication.all
  end

  # GET /biographies/1
  # GET /biographies/1.json
  def show; end

  # GET /biographies/new
  def new
    @publication = Publication.new(user: @user)
  end

  # GET /biographies/1/edit
  def edit; end

  # POST /biographies
  # POST /biographies.json
  def create
    user_object = User.find(publication_params[:user_id])
    publication_params[:user] = user_object
    @publication = Publication.new(publication_params)
    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /biographies/1
  # PATCH/PUT /biographies/1.json
  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /biographies/1
  # DELETE /biographies/1.json
  def destroy
    @publication.destroy
    respond_to do |format|
      success_str = 'Publication was successfully destroyed.'
      format.html { redirect_to biographies_url, success: success_str }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_user
    @user = User.find(params[:user_id])
  end

  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def publication_params
    params.require(:publication).permit(:user_id, :description)
  end
end
