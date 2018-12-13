# Departments Controller
# @author David J. Davis
# Sets data for views, sets redirects, sets errors
class Admin::DepartmentsController < AdminController
    # tell rails which view layout to use with this controller
  layout 'admin'

  # before_actions
  before_action :set_department, only: %i[show edit update destroy]

  # GET admin/departments
  # GET admin/departments.json
  def index
    @departments = Department.all.order(:name)
  end

  # GET /departments/1
  # GET /departments/1.json
  def show; end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit; end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    respond_to do |format|
      if @department.save
        format.html { redirect_to admin_department_path(@department), success: I18n.t('department.success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to admin_department_path(@department), success: I18n.t('department.edited') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/departments', success: I18n.t('department.deleted') }
    end
  end

  # Private Methods
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = Department.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def department_params
    params.require(:department)
    .permit( :name, :status )
  end
end
