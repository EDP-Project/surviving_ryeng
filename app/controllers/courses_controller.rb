class CoursesController < ApplicationController
  
  before_action :authenticate_user!, except: [:show]

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
    @courses = Course.all
  end

  def show
    course
    @enrollment = Enrollment.new
  end

private

  def course
    @course = Course.find_by course_code: params[:course_code]
  end

  def course_params
    params.require(:course).permit(:id, :course_code, :title, :description)
  end
end
