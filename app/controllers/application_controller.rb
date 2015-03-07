class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #use_growlyflash

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ban_check
  before_action :check_authorization, only: [:approve]
  #before_action :save_previous_url


  def approve
    case params[:resource]
    when "attachment"
      @attachment = Attachment.find(params[:id])
      @attachment.approved = true
      @attachment.save
    when "guide"
      @guide = Guide.find(params[:id])
      @guide.approved = true
      @guide.save
    end
    redirect_to admin_feed_path, notice: "You have successfully approved the #{params[:resource]}."
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit( :email, :password, :password_confirmation, :current_password) }
  end

  private

  def redirect_standard_users
    unless current_user.admin?
      redirect_to root_path, notice: "You tried to access a restricted area."
    end
  end

  def check_authorization
    redirect_to root_path, notice: "You tried accessing a restricted area." unless current_user.admin?
  end

  def ban_check
    if (user_signed_in? && current_user.banned?)
      r = current_user.ban_reason
      sign_out current_user
      redirect_to root_path(banned: true), notice: r
    end
  end

end
