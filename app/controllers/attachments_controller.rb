class AttachmentsController < ApplicationController

  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: [:create]


  def index
    if params[:for_course]
      @attachments = Attachment.where(attachable_type: 'Course', attachable_id: params[:for_course])
    elsif params[:q]
      #Find guides based on search query
    else
      @attachments = Attachment.all
    end
  end

  def show
    attachment
    @report = @attachment.reports.build
    @attachments = Attachment.where(description: @attachment.description)

    
  end
  def new
    @attachment = Attachment.new
    @attachments = Attachment.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attachment }
    end
  end

  def create
    find_attachable
    params[:uploads].each do |u| 
      @attachment = Attachment.new(attachment_create_params)
      @attachment.user = current_user;
      @attachment.upload = u

      if @attachment.save
        flash[:success] = "Attachment(s) submitted for approval"
      else
        flash[:error] = "Unable to submit attachment(s)"
      end
    end
    redirect_to course_path(course_code: @attachable.course_code)
  end

  def destroy
    find_attachable
    if user_permitted?
      if @attachment.destroy 
        if @attachment.attachable_type == "Guide"
          flash[:success] = "Attachment successfully removed from guide"
          redirect_to edit_guide_path(id: params[:guide_id])
        else
          flash[:success] = "Attachment successfully removed from course"
          redirect_to @attachable
        end
       
      else
        flash[:error] = "Could not remove attachment"
        redirect_to root_path
      end

    else
      redirect_to root_path, notice: "You are not permitted to perform this action"
    end
  end

  def download
    attachment
    @attachment.download_count += 1
    @attachment.save
    send_file @attachment.upload.path,
              filename: @attachment.upload_file_name,
              disposition: 'attachment'
  end

private

def attachment
  @attachment = Attachment.find(params[:id])
end
  
  def attachment_create_params
    params.require(:attachment).permit(:id, :course_id, :description, :attachable_type, :attachable_id)
  end

  def user_permitted?
    @attachment = Attachment.find(params[:id])
    @attachment.user == current_user || current_user.admin?
  end

  def find_attachable
    if params[:attachment][:attachable_type] == "Course"
      return @attachable = Course.find(params[:attachment][:attachable_id])
    elsif params[:attachment][:attachable_type] == "Guide"
      return @attachable = Guide.find(params[:attachment][:attachable_id])
    end
  end

end
