class GuidesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @guide = Guide.new
    @attachment = @guide.attachments.build
  end

  def create
    @guide = Guide.new(new_guide_params)
    @course = Course.find(params[:guide][:course_id] || params[:course_id])
    @guide.user_id = current_user.id
    @course_id = params[:guide][:course_id] || params[:course_id]
    if @guide.save
      #If guide was submitted with attachments, create them
      if params[:attachments].present?
        params[:attachments]['contents'].each do |c|
          @attachment = @guide.attachments.create!(contents: c, attachable_id: @guide.id, attachable_type: 'guide')
        end
      end
      flash[:notice] = "You've submitted a guide for #{@course.course_code}!"
      redirect_to course_path(course_code: @course.course_code)
    else
      flash[:error] = "Sorry, could not submit guide for #{@guide.course.course_code}."
      redirect_to new_guide_path(course_id: params[:guide][:course_id])
    end
  end

  def show
    guide
    @attachments = guide.attachments
  end

  def edit
    guide
    @attachments = guide.attachments
  end

  def update
    if guide.update_attributes(guide_update_params)

      #If more attachments are added
      if params[:attachments].present?
        params[:attachments]['contents'].each do |c|
          @attachment = @guide.attachments.create!(contents: c, attachable_id: @guide.id, attachable_type: 'guide')
        end
      end

      flash[:success] = "Guide updated successfully!"
      redirect_to guide_path(guide)
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

private

  def guide
    @guide = Guide.find(params[:id]) 
  end

  def new_guide_params
    params.required(:guide).permit(:id, :title, :content, :user_id, :course_id, attachments_attributes: [:id, :guide_id, :content])
  end

  def guide_update_params
    params.required(:guide).permit(:id, :title, :content, :user_id, attachments_attributes: [:id, :guide_id, :content])
  end
end
