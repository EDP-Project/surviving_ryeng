class MainPagesController < ApplicationController
  
  before_action :authenticate_user!, only: [:admin_feed]

  def admin_feed
    if current_user.admin?
      @reports = Report.all
      @unapproved_guides = Guide.where(approved: false)
    else
      redirect_to root_path
    end
  end


  def home
  	
  end

  def contact
  end

  def about
  end



end
