class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends.page(params[:page_1]).per(24)
    @friend_requests_received = FriendRequest.where(receiver_id: current_user.id).page(params[:page_2]).per(24)
    @friend_requests_sent = FriendRequest.where(user_id: current_user.id).page(params[:page_3]).per(24)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @other_user = User.find(params[:friend_id])
    @other_friendship = @other_user.friendships.build(friend_id: current_user.id)
    @friend_request = FriendRequest.where(user_id: params[:friend_id], receiver_id: current_user.id)[0]

    if @friendship.save && @other_friendship.save && @friend_request.destroy  
      flash[:notice] = "Friend added"
      FriendRequest.cleanup(current_user.id, params[:friend_id])
      redirect_to friendships_path
    else
      flash[:alert] = "Unable to add friend"
      redirect_to friendships_path 
    end
  end

  def destroy
    @friendship = Friendship.find_by(user_id: current_user.id)
    @other_friendship = Friendship.find_by(friend_id: current_user.id)

    if @friendship.destroy && @other_friendship.destroy
      flash[:notice] = "Friend Removed."
      redirect_to friendships_path
    else
      flash[:alert] = "Unable to remove friend"
      redirect_to friendships_path
    end
  end
end
