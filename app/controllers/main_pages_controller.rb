class MainPagesController < ApplicationController
  
  before_action :authenticate_user!, only: [:admin_feed]

  def admin_feed
    check_authorization
    @reports = Report.all.page(params[:rp]).per(6)
    @unapproved_guides = Guide.where(approved: false).page(params[:gp]).per(6)
    @unapproved_attachments = Attachment.where(approved: false).page(params[:ap]).per(6)
  end


  def home
  	
  end

  def contact
  end

  def about
  end



end
