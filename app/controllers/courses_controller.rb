class CoursesController < ApplicationController
  
  before_action :authenticate_user!

  def new
    unless current_user.admin?
      flash[:error] = "You tried accessing a restricted area. You have been redirected."
      redirect_to root_path
    end
    @course = Course.new
  end

  def edit
    course
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Course created"
      redirect_to course_path(course_code: @course.course_code)
    else
      flash[:error] = "Course: #{@course.course_code} was not saved properly"
      render 'new'
    end
  end

  def index
    if params[:q] 
      @courses = Course.search(params[:q]).page(params[:cpage]).per(10)
    else
      @courses = Course.all.page(params[:cpage]).per(10)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    course
    @guide = @course.guides.build
    @attachment = @course.attachments.build
    @guides = @course.guides.where(approved: true).limit(3)
    @attachments = @course.attachments.approved.limit(6)
    @enrollment = @course.enrollments.where(user_id: current_user.id)
    # Find last few enrolled users for display
    @recently_enrolled_users = []
    @last_enrollments = @course.enrollments.order('updated_at DESC').limit(4)
    
    @last_enrollments.each do |e|
      @recently_enrolled_users << e.user 
    end

    respond_to do |format| 
      format.html 
      format.js
    end
  end

private

  def course
    @course = Course.find_by course_code: params[:course_code]
  end

  def course_params
    params.require(:course).permit(:id, :course_code, :title, :description)
  end
end
