class Admin::OptionalItemsController < ApplicationController
  # tell rails which view layout to use with this controller
  layout 'admin'

  before_action :find_user, only: [:index, :new, :edit]
  before_action :publication_params, :website_params, only: [:show, :update, :destroy]

  # GET /optional_items
  # GET /optional_items.json
  def index; end

  # GET /optional_items/1
  # GET /optional_items/1.json
  def show
  end

  # GET /optional_items/new
  def new
    @user.phone.new
    @user.publication.new
    @user.websites.new

    # @email_address = EmailAddress.new(user: @user)
    # @address = Address.new(user: @user)
    # @website = Website.new(user: @user)
    # @phone = Phone.new(user: @user)
    # @publication = Publication.new(user: @user)
  end

  # GET /optional_items/1/edit
  def edit
    @user.phones.new
    @user.publications.new
    @user.websites.new
  end

  # POST /optional_items
  # POST /optional_items.json
  def create
    @user = User.find(website_params[:user_id])

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

    def publication_params
      params.require(:user).permit(:user_id, publications_attributes: [:id, :description])
    end

    def website_params
      params.require(:user).permit(:user_id, websites_attributes: [:id, :website_url])
    end
end
