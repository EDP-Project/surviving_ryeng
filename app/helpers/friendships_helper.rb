module FriendshipsHelper
  def display_friend_name(friendship)
    if current_user.username == friendship.user.username
      friendship.friend.username
    else
      friendship.user.username
    end
  end
end
