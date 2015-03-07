class MainPagesController < ApplicationController
  
  before_action :authenticate_user!, only: [:admin_feed]

  def admin_feed
    check_authorization
    @reports = Report.all
    @unapproved_guides = Guide.where(approved: false)
    @unapproved_attachments = Attachment.where(approved: false)
  end


  def home
  	
  end

  def contact
  end

  def about
  end



end
