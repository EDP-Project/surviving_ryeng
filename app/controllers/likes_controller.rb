class LikesController < ApplicationController
  def create
    find_resource
    @like = current_user.likes.build
    @like.likeable = @resource
    if @like.save
      flash[:success] = "Added to favourites"
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
    when "course"
      @resource = Course.find params[:id]
    end
  end
end
