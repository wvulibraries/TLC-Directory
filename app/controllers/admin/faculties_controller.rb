class Admin::FacultiesController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  include CSVService

  before_action :set_faculty, only: %i[show edit update destroy]

  # GET /faculties
  # GET /faculties.json
  def index
    @faculties = Faculty.order(:last_name, :first_name)
  end

  # GET /faculties/1
  # GET /faculties/1.json
  def show; end

  # GET /faculties/new
  def new
    @faculty = Faculty.new
  end

  # GET /faculties/1/edit
  def edit; end

  # POST /faculties
  # POST /faculties.json
  def create
    @faculty = Faculty.new faculty_params  
    respond_to do |format|
      if @faculty.save
        format.html { redirect_to @faculty, success: I18n.t('faculty.success') }
        format.json { render :show, status: :created, location: @faculty }
      else
        format.html { render :new }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faculties/1
  # PATCH/PUT /faculties/1.json
  def update
    respond_to do |format|
      if @faculty.update faculty_params
        format.html { redirect_to @faculty, success: I18n.t('faculty.edited') }
        format.json { render :show, status: :created, location: @faculty }
      else
        format.html { render :new }
        format.json { render json: @faculty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faculties/1
  # DELETE /faculties/1.json
  def destroy
    @faculty.destroy
    respond_to do |format|
      format.html { redirect_to faculties_url, success: I18n.t('faculty.deleted') }
      format.json { head :no_content }
    end
  end

  def import 
    @errors = []
    if upload_params[:csv_files].present?
      wizard = CSVService::CSVImport.new({:csv_files => upload_params[:csv_files]})
      if wizard.errors.count > 0
        @errors << wizard.errors 
      else
        flash.now[:notice] = I18n.t('faculty.csv_import_queued')
      end
    end

    if upload_params[:zip_file].present?
        zip_import = CSVService::ZipImport.new(upload_params)
        if zip_import.errors.count > 0
          @errors << zip_import.errors 
        else
          flash.now[:notice] = upload_params[:zip_file].original_filename + I18n.t('faculty.zip_import_queued')
        end
    end

    flash.now[:error] = @errors if @errors.count > 0
    
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_faculty
    @faculty = Faculty.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def faculty_params
    params.require(:faculty)
          .permit(:prefix,
                  :suffix,
                  :first_name,
                  :middle_name,
                  :last_name,
                  :preferred_name,
                  :image,
                  :image_cache,
                  :remove_image, 
                  :resume,
                  :resume_cache,
                  :remove_resume,                   
                  :wvu_username,
                  :email,
                  :title,
                  :biography,
                  :status,
                  :role,
                  :visible,
                  :research_interests,
                  :college_id, 
                  :department_id,     
                  addresses_attributes: %i[id street_address_1 street_address_2 city state zip_code _destroy],
                  awards_attributes: %i[id starting_year ending_year name organization description _destroy],
                  phones_attributes: %i[id number number_types _destroy],
                  publications_attributes: %i[id starting_year ending_year title url description _destroy],
                  websites_attributes: %i[id url _destroy]           
                )
    end

    def upload_params
      params.permit({csv_files: []}, :zip_file)
    end
end
