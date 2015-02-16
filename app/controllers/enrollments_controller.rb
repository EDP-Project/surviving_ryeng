class EnrollmentsController < ApplicationController

  before_action :authenticate_user!

  def index
    @enrollments = Enrollment.where(user_id: current_user.id)
  end
  
  def create
    @enrollment = current_user.enrollments.build
    @course = Course.find(params[:course_id])
    @enrollment.course = @course

    if @enrollment.save
      flash[:success] = "Successfully enrolled into #{@course.course_code}!"
      redirect_to course_path(course_code: @course.course_code)
    else
      flash[:error] = "Could not enroll you into #{@course.course_code}. You may already be enrolled."
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    if @enrollment.destroy
      flash[:success] = "Removed you from #{@enrollment.course.course_code}"
      redirect_to enrollments_path
    else
      flash[:error] = "Could not remove you from the course."
      redirect_to enrollments_path
    end
  end

end
