module FriendshipsHelper
  def display_friend_name(friendship)
    if current_user.username == friendship.user.username
      friendship.friend.username
    else
      friendship.user.username
    end
  end

  def display_friend_gravatar(friendship, user)
    if user == friendship.user
      gravatar_for friendship.friend
    else
      gravatar_for friendship.user
    end
  end

  def friend_link(friendship, user)
    if user == friendship.user
      user_path(username: friendship.friend.username)
    else
      user_path(username: friendship.user.username)
    end
  end
end
