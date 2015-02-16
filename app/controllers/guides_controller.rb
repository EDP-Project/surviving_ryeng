class GuidesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @guide = Guide.new
    @attachment = @guide.attachments.build
  end

  def create
    @guide = Guide.new(guide_params)
    @course = Course.find(params[:guide][:course_id])
    @guide.user_id = current_user.id
    if @guide.save
      params[:attachments]['contents'].each do |c|
        @attachment = @guide.attachments.create!(contents: c, attachable_id: @guide.id, attachable_type: 'guide')
      end
      flash[:notice] = "You've submitted a guide for #{@course.course_code}!"
      redirect_to course_path(course_code: @course.course_code)
    else
      flash[:error] = "Sorry, could not submit guide for #{@guide.course.course_code}."
      render 'new'
    end
  end

  def show
    guide
    @attachments = guide.attachments
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
    params.required(:guide).permit(:id, :title, :content, :user_id, :course_id, attachments_attributes: [:id, :guide_id, :content])
  end
end
