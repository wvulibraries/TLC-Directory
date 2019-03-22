# frozen_string_literal: true

# Colleges Controller
# @author Tracy A. McCormick
# Sets data for views, sets redirects, sets errors
class Admin::CollegesController < AdminController
  # tell rails which view layout to use with this controller
  layout 'admin'

  # before_actions
  before_action :set_college, only: %i[show edit update destroy]

  # GET admin/colleges
  # GET admin/colleges.json
  def index
    @colleges = College.all.order(:name)
  end

  # GET /colleges/1
  # GET /colleges/1.json
  def show; end

  # GET /colleges/new
  def new
    @college = College.new
  end

  # GET /colleges/1/edit
  def edit; end

  # POST /colleges
  # POST /colleges.json
  def create
    @college = College.new(college_params)
    respond_to do |format|
      if @college.save
        format.html { redirect_to admin_college_path(@college), success: I18n.t('college.success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /colleges/1
  # PATCH/PUT /colleges/1.json
  def update
    respond_to do |format|
      if @college.update(college_params)
        format.html { redirect_to admin_college_path(@college), success: I18n.t('college.edited') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /colleges/1
  # DELETE /colleges/1.json
  def destroy
    @college.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/colleges', success: I18n.t('college.deleted') }
    end
  end

  # Private Methods
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_college
    @college = College.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def college_params
    params.require(:college)
          .permit(:name, :status)
  end
end
