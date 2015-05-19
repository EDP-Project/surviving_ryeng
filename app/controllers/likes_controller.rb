class LikesController < ApplicationController
  
  def index
    @favourites = current_user.likes
    @guides = @favourites.where(likeable_type: "Guide").page(params[:gpage]).per(10)
    @attachments = @favourites.where(likeable_type: "Attachment").page(params[:apage]).per(10)
  end

  def create
    find_resource
    @like = current_user.likes.build
    @like.likeable = @resource
    if @like.save
      flash[:success] = "Added to your favourites. #{view_context.link_to 'View my favourites', favourites_path}"
    else
      flash[:error] = "Unable to add to favourites"
    end

    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def destroy
    find_resource
    @like = @resource.likes.where(liker_id: current_user.id)
    
    if @like.destroy_all
      flash[:success] = "Removed from favourites"
    else
      flash[:error] = "Unable to remove from favourites"
    end

    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

private

  def find_resource
    case params[:resource]
    when "guide"
      @resource = Guide.find params[:id]
    when "attachment"
      @resource = Attachment.find params[:id]
    end
  end
end
