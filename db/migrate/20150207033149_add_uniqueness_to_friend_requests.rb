class AddUniquenessToFriendRequests < ActiveRecord::Migration
  def change
    add_index :friend_requests, [:user_id, :receiver_id], unique: true
  end
end
