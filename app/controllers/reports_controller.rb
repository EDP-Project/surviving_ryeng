class ReportsController < ApplicationController



  def create
    find_reportable
    @report = Report.new(report_create_params)
    @report.reporter = current_user
    
    if @report.save
      flash[:notice] = "Report submitted."
    else
      flash[:error] = "Unable to submit report."
    end 

    respond_to do |format|

      format.js
      format.html { redirect }

    end
  end

  def show
    report
  end

  def destroy
    report
    if @report.destroy
      redirect_to admin_feed_path, notice: "Report destroyed."
    else
      falsh[:error] = "Unable to remove report"
      redirect_to report_path(@report)
    end
  end


private
  
  def report
    @report = Report.find(params[:id])
  end

  def report_create_params
    params.require(:report).permit(:id, :title, :reason, :reportable_type, :reportable_id)
  end

  def find_reportable
    if params[:report][:reportable_type] == "User"
      return @reportable = User.find(params[:report][:reportable_id])
    elsif params[:report][:reportable_type] == "Guide"
      return @reportable = Guide.find(params[:report][:reportable_id])
    elsif params[:report][:reportable_type] == "Attachment"
      return @reportable = Attachment.find(params[:report][:reportable_id])
    end
  end

  def redirect
    if @reportable.class == (User || Guide)
      redirect_to @reportable
    elsif @reportable.class == Attachment
      course = Course.find(@reportable.attachable_id)
      redirect_to course_path(course_code: course.course_code)
    end
  end
end
