class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  def index
    @users = User.all

    #Uncomment when using kaminari + search
    # if params[:query].present? 
    #   @users = User.search(params[:query]).page(params[:page]).per(12)
    # else
    #   @users = User.all.page(params[:page]).per(12)
    # end
  end

  def show
    if params[:username].present?
      @user = User.find_by username: params[:username]
    elsif params[:id].present?
      @user = User.find(params[:id])
    else
      flash[:notice] = "Unable to find user"
    end
  end
end
