class PicturesController < ApplicationController

   #Index action, photos gets listed in the order at which they were created
   def index
    @pictures = Picture.order('created_at')
   end

   # New action for creating a new photo
   def new
    @picture = Picture.new
   end

   # Create action ensures that submitted photo gets created if it meets the requirements
   def create
    @picture = Picture.new(picture_params)
    if @picture.save
     flash[:notice] = "Successfully added new picture!"
     redirect_to root_path
    else
     flash[:alert] = "Error adding new picture!"
     render :new
    end
   end

   private

   #Permitted parameters when creating a photo. This is used for security reasons.
   def picture_params
     params.require(:picture).permit(:image)
   end

end
