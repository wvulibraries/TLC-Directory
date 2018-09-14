class Admin::OptionalItemsController < ApplicationController
  include OptionalItemsConcern

  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: %i[index new edit]
  before_action :create_empty_fields, only: %i[new edit]
  before_action :address_params,
                :publication_params,
                :website_params,
                only: %i[show update destroy]

  # GET /optional_items
  # GET /optional_items.json
  def index; end

  # GET /optional_items/1
  # GET /optional_items/1.json
  def show
  end

  # GET /optional_items/new
  def new
  end

  # GET /optional_items/1/edit
  def edit
  end

  # POST /optional_items
  # POST /optional_items.json
  def create
    @user = User.find(website_params[:user_id])

    address_params[:addresses_attributes].each do |_key, item|
      process_address(website_params[:user_id], item)
    end

    award_params[:awards_attributes].each do |_key, item|
      process_description(website_params[:user_id], item)
    end

    email_address_params[:email_addresses_attributes].each do |_key, item|
      process_email_address(website_params[:user_id], item)
    end

    phone_params[:phones_attributes].each do |_key, item|
      process_phone(website_params[:user_id], item)
    end

    publication_params[:publications_attributes].each do |_key, item|
      process_publication(website_params[:user_id], item)
    end

    website_params[:websites_attributes].each do |_key, item|
      process_website(website_params[:user_id], item)
    end

    redirect_to @user
  end

  # PATCH/PUT /optional_items/1
  # PATCH/PUT /optional_items/1.json
  def update
    puts "update function"
    # puts website_params
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

  def create_empty_fields
    @user.addresses.new
    @user.awards.new
    @user.email_addresses.new
    @user.phones.new
    @user.publications.new
    @user.websites.new
  end

  def address_params
    params.require(:user).permit(:user_id, addresses_attributes: %i[id street_address_1 street_address_2 city state zip_code])
  end

  def award_params
    params.require(:user).permit(:user_id, awards_attributes: %i[id description])
  end

  def email_address_params
    params.require(:user).permit(:user_id, email_addresses_attributes: %i[id email])
  end

  def phone_params
    params.require(:user).permit(:user_id, phones_attributes: %i[id number number_type])
  end

  def publication_params
    params.require(:user).permit(:user_id, publications_attributes: %i[id description])
  end

  def website_params
    params.require(:user).permit(:user_id, websites_attributes: %i[id website_url])
  end
end
