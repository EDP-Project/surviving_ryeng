class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend_request = current_user.friend_requests.build
    @friend_request.receiver = receiver
    if @friend_request.save
      flash[:notice] = "Sent friend request!"
      redirect_to user_path(username: @receiver.username)
    else
      flash[:error] = "Unable to send friend request. You may have already sent one to this user."
      redirect_to user_path(username: @receiver.username)
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.destroy
      flash[:notice] = "Removed friend request"
      redirect_to friendships_path
    else
      flash[:alert] = "Unable to remove friend request"
      redirect_to friendships_path
    end
  end

private 

  def receiver
    @receiver = User.find(params[:user_id])
  end
end
