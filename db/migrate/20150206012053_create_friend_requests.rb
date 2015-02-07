class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.references :user
      t.references :receiver
      t.timestamps
    end
  end
end
