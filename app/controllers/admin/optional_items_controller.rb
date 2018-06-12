class Admin::OptionalItemsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:index, :new, :edit]
  before_action :create_empty_fields, only: [:new, :edit]
  before_action :address_params, :publication_params, :website_params, only: [:show, :update, :destroy]

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

    address_params[:addresses_attributes].each do |key, item|
      if item['id'] == '' && item['street_address_1'] != '' && item['city'] != '' && item['state'] != '' && item['zip_code'] != ''
        @user.addresses.build(street_address_1: item['street_address_1'], street_address_2: item['street_address_2'], city: item['city'], state: item['state'], zip_code: item['zip_code'])
        @user.save
      elsif item['id'] != '' && item['street_address_1'] != '' && item['city'] != '' && item['state'] != '' && item['zip_code'] != ''
        address_object = Address.find(item['id'])
        if address_object.street_address_1 != item['street_address_1'] || address_object.street_address_2 != item['street_address_2'] || address_object.city != item['city'] || address_object.state != item['state'] || address_object.zip_code != item['zip_code']
          address_object.update(street_address_1: item['street_address_1'], street_address_2: item['street_address_2'], city: item['city'], state: item['state'], zip_code: item['zip_code'])
        end
      elsif item['id'] != '' && item['street_address_1'] == '' && item['street_address_2'] == '' && item['city'] == '' && item['state'] == '' && item['zip_code'] == ''
        address_object = Address.find(item['id'])
        address_object.destroy
      end
    end

    award_params[:awards_attributes].each do |key, item|
      if item['id'] == '' && item['description'] != ''
        @user.awards.build(description: item['description'])
        @user.save
      elsif item['id'] != '' && item['description'] != ''
        award_object = Award.find(item['id'])
        if award_object.description != item['description']
          award_object.update(description: item['description'])
        end
      elsif item['id'] != '' && item['description'] == ''
        award_object = Award.find(item['id'])
        award_object.destroy
      end
    end

    email_address_params[:email_addresses_attributes].each do |key, item|
      if item['id'] == '' && item['email'] != ''
        @user.email_addresses.build(email: item['email'])
        @user.save
      elsif item['id'] != '' && item['email'] != ''
        email_object = EmailAddress.find(item['id'])
        if email_object.email != item['email']
          email_object.update(email: item['email'])
        end
      elsif item['id'] != '' && item['email'] == ''
        email_object = EmailAddress.find(item['id'])
        email_object.destroy
      end
    end

    phone_params[:phones_attributes].each do |key, item|
      if item['id'] == '' && item['phone_number'] != '' && item['type'] != ''
        @user.phones.build(phone_number: item['phone_number'], phone_type: item['phone_type'])
        @user.save
      elsif item['id'] != '' && item['phone_number'] != '' && item['phone_type'] != ''
        phone_object = Phone.find(item['id'])
        if phone_object.phone_number != item['phone_number'] || phone_object.phone_type != item['phone_type']
          phone_object.update(phone_number: item['phone_number'], phone_type: item['phone_type'])
        end
      elsif item['id'] != '' && item['phone_number'] == '' && item['phone_type'] == ''
        phone_object = Phone.find(item['id'])
        phone_object.destroy
      end
    end

    publication_params[:publications_attributes].each do |key, item|
      if item['id'] == '' && item['description'] != ''
        @user.publications.build(description: item['description'])
        @user.save
      elsif item['id'] != '' && item['description'] != ''
        publication_object = Publication.find(item['id'])
        if publication_object.description != item['description']
          publication_object.update(description: item['description'])
        end
      elsif item['id'] != '' && item['description'] == ''
        publication_object = Publication.find(item['id'])
        publication_object.destroy
      end
    end

    website_params[:websites_attributes].each do |key, item|
      if item['id'] == '' && item['website_url'] != ''
        @user.websites.build(website_url: item['website_url'])
        @user.save
      elsif item['id'] != '' && item['website_url'] != ''
        website_object = Website.find(item['id'])
        if website_object.website_url != item['website_url']
          website_object.update(website_url: item['website_url'])
        end
      elsif item['id'] != '' && item['website_url'] == ''
        website_object = Website.find(item['id'])
        website_object.destroy
      end
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
      params.require(:user).permit(:user_id, addresses_attributes: [:id, :street_address_1, :street_address_2, :city, :state, :zip_code])
    end

    def award_params
      params.require(:user).permit(:user_id, awards_attributes: [:id, :description])
    end

    def email_address_params
      params.require(:user).permit(:user_id, email_addresses_attributes: [:id, :email])
    end

    def phone_params
      params.require(:user).permit(:user_id, phones_attributes: [:id, :phone_number, :phone_type])
    end

    def publication_params
      params.require(:user).permit(:user_id, publications_attributes: [:id, :description])
    end

    def website_params
      params.require(:user).permit(:user_id, websites_attributes: [:id, :website_url])
    end
end
