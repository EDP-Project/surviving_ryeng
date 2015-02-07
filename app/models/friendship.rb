class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: [:friend_id] }

  def self.friendship_exists? (user_a, user_b)
    @friendship = Friendship.where(user_id: user_a.id, friend_id: user_b.id)
    @friendship.exists?
  end
end
