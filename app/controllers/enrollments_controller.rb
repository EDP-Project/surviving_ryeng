class EnrollmentsController < ApplicationController

  def create
    @enrollment = current_user.enrollments.build
    @enrollment.course_id = params[:course_id]

    if @enrollment.save
      flash[:success] = "Successfully enrolled into #{@enrollment.course.course_code}!"
      redirect_to course_path(course_code: @enrollment.course.course_code)
    else
      flash[:error] = "Could not enroll you into #{@enrollment.course.course_code)}."
    end
  end

  def destroy
    
  end

end
