class LikesController < ApplicationController
  
  def index
    @likes = current_user.likes
    @guides = Guide.none
    @attachments = Attachment.none
    @likes.each do |l|
      if l.likeable_type == "Guide"
        @guides << Guide.find(l.likeable_id)
      elsif l.likeable_type == "Attachment"
        @attachments << Attachment.find(l.likeable_id)
      end
    end

    @guides = @guides.page(params[:gpage]).per(6)
    @attachments = @attachments.page(params[:apage]).per(6)
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
