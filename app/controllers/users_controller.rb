class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show, :banned]
  before_action :check_authorization, only: [:ban, :unban]
  def index
    if params[:q].present? 
      @users = User.search(params[:q]).page(params[:upage]).per(6)
    else
      @users = User.all.page(params[:upage]).per(6)
    end
  end

  def show
    if params[:username].present?
      @user = User.find_by username: params[:username]
    elsif params[:id].present?
      @user = User.find(params[:id])
    else
      flash[:notice] = "Unable to find user"
    end
    @report = @user.reports.build
    @friends = @user.friends.order('created_at DESC').limit(4)
    @conversation = current_user.mailbox.conversations.build
    @attachments = @user.attachments.where(attachable_type: "Course")
  end

  def ban
    user
    @user.banned = true
    @user.ban_reason = params[:ban_reason]
    if @user.save
      flash[:success] = "Successfully banned user."
    else
      flash[:error] = "Unable to ban user."
    end
    redirect_to user_path(username: @user.username)
  end

  def unban
    user
    @user.banned = false
    @user.ban_reason = nil
    if @user.save 
      flash[:success] = "Successfully un-banned user."
    else
      flash[:error] = "Unable to un-ban user."
    end
    redirect_to user_path(username: @user.username)
  end

  def destroy
    user
    if current_user.admin? && @user.destroy
      redirect_to root_path, notice: "User was successfully removed."
    else
      redirect_to :back, notice: "Unable to remove user."
    end
  end

private
  
  def user
    @user = User.find(params[:id])  
  end

end
