class GuidesController < ApplicationController

  def create
    @guide = Guide.new(guide_params)
    @guide.course_id = params[:course_id]
    @guide.user_id = current_user.id
    if @guide.save
      flash[:success] = "You've submitted a guide for #{@guide.course.course_code}!"
      redirect_to course_path(course_code: @guide.course.course_code)
    else
      flash[:error] = "Sorry, could not submit guide for #{@guide.course.course_code}."
      redirect_to course_path(course_code: @guide.course.course_code)
    end
  end

  def show
    guide
  end

  def edit
    guide
  end

  def update
    if guide.update_attributes(guide_params)
        flash[:success] = "Guide updated successfully!"
      redirect_to guide_path(guide)
    else
      flash[:error] = "Sorry, could not update the guide."
      redirect_to guide_path(guide)
    end

  end

private

  def guide
    @guide = Guide.find(params[:id]) 
  end

  def guide_params
    params.required(:guide).permit(:id, :title, :content, :user_id, :course_id)
  end
end
