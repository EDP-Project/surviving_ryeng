class AttachmentsController < ApplicationController

  before_action :authenticate_user!


  def destroy
    find_attachable
    if user_permitted?
      if @attachment.destroy 

        if @attachment.attachable_type == "Guide"
          flash[:success] = "Attachment successfully removed from guide"
          redirect_to edit_guide_path(id: params[:guide_id])
        else
          flash[:success] = "Attachment successfully removed from course"
          redirect_to @attachable
        end
       
      else
        flash[:error] = "Could not remove attachment"
        redirect_to root_path
      end

    else
      redirect_to root_path, notice: "You are not permitted to perform this action"
    end
  end

private
  
  def attachment_params
    params.require(:attachment).permit(:attachment)
  end

  def user_permitted?
    @attachment = Attachment.find(params[:id])
    @attachment.user == current_user || current_user.admin?
  end

  def find_attachable
    params.each do |name, value|
      return @attachable = $1.classify.constantize.find(value) if name =~ /(.+)_id$/
    end
  end

end
