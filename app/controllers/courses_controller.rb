class CoursesController < ApplicationController
  
  before_action :authenticate_user!, except: [:show]

  def new
    unless current_user.admin?
      flash[:error] = "You tried accessing a restricted area. You have been redirected."
      redirect_to root_path
    end
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:success] = "Course created"
      redirect_to course_path(course_code: @course.course_code)
    else
      flash[:error] = "Course: #{@course.course_code} was not saved properly"
      render 'new'
    end
  end

  def index
  end

  def show
    course
  end

private

  def course
    @course = Course.find_by course_code: params[:course_code]
  end
end
