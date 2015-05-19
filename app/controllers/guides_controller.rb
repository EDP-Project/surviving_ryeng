#If guide was submitted with attachments, create them
      # if params[:attachments].present?
      #   params[:attachments]['contents'].each do |c|
      #     @attachment = @guide.attachments.create!(contents: c, attachable_id: @guide.id, attachable_type: 'guide')
      #   end
      # end
class GuidesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  skip_before_filter :verify_authenticity_token, only: [:create]


  def index
    if params[:for_course]
      @guides = Guide.where(course_code: params[:for_course]).page(params[:gpage]).per(6)
    elsif params[:q]
      @guides = Guide.search(params[:q]).approved.page(params[:gpage]).per(6)
    else
      @guides = Guide.all.page(params[:gpage]).per(6)
    end
  end


  def new
    @guide = Guide.new
    @attachment = @guide.attachments.build
  end

  def create

    if session[:_course]
      @course = Course.find(session[:_course])
      session.delete :_course
    else
      @course = Course.find(params[:guide][:course_id])
    end

    @guide = Guide.new(new_guide_params)
    @guide.user_id = current_user.id
    @guide.course = @course


      if @guide.save
        
        if params[:uploads]
          params[:uploads].each { |u| @guide.attachments.create!(upload: u, user: current_user) }
        end

        flash[:notice] = "You've submitted a guide for #{@course.course_code}!"

        # Successful redirects
        respond_to do |format|
          format.js 
          format.html { redirect_to course_path(course_code: @course.course_code) }
        end

      else
        flash[:error] = "Sorry, could not submit guide for #{@guide.course.course_code}."
        session[:_course] = @course.id

        # Render errors via AJAX into modal
        respond_to do |format| 
          format.html { redirect_to course_path(course_code: @course.course_code) }
          format.js
        end
      end
    
  end

  def show
    guide
    unless @guide.approved
      unless (@guide.user == current_user || current_user.admin?)  
        redirect_to root_path, notice: "You may not view this guide; it has not been approved by an administrator."
      end
    end
    @attachments = guide.attachments.page(params[:apage]).per(3)
    @report = @guide.reports.build
    @like_type = 'btn'
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    if guide.update_attributes(guide_update_params)

      #If more attachments are added
      if params[:uploads]
          params[:uploads].each { |u| @guide.attachments.create!(upload: u, user: current_user) }
      end

      flash[:success] = "Guide updated successfully!"
      

      respond_to do |format|
        format.js 
        format.html { redirect_to guide_path(@guide) }
      end
    else
      flash[:error] = "Sorry, could not update the guide."
      redirect_to guide_path(guide)
    end
  end

  def destroy
    guide
    if @guide.destroy
      flash[:success] = "Guide removed successfully."
      redirect_to course_path(course_code: @guide.course.course_code)
    else
      flash[:error] = "Unable to remove guide."
      redirect_to courses_path
    end
  end

  def like
    guide.like
    respond_to do |format|
      format.js
      format.html { redirect_to @guide }
    end
  end

  def dislike
    guide.dislike
    respond_to do |format|
      format.js
      format.html { redirect_to @guide }
    end
  end

private

  def guide
    @guide = Guide.find(params[:id]) 
  end

  def new_guide_params
    params.required(:guide).permit(:id, :title, :content, :user_id, :course_id, attachments_attributes: [:id, :guide_id, :upload])
  end

  def guide_update_params
    params.required(:guide).permit(:id, :title, :content, :user_id, attachments_attributes: [:id, :guide_id, :content, :upload])
  end
end
