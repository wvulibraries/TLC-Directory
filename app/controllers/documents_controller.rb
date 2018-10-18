class DocumentsController < ApplicationController

   #Index action, photos gets listed in the order at which they were created
   def index
    @documents = Document.order('created_at')
   end

   # New action for creating a new photo
   def new
    @document = Document.new
   end

   # Create action ensures that submitted photo gets created if it meets the requirements
   def create
    @document = Document.new(document_params)
    if @document.save
     flash[:notice] = "Successfully added new document!"
     redirect_to root_path
    else
     flash[:alert] = "Error adding new document!"
     render :new
    end
   end

   private

   #Permitted parameters when creating a photo. This is used for security reasons.
   def document_params
     params.require(:document).permit(:document)
   end

end
