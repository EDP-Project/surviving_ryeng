class Friendship < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  #-- Validations
  validates :user_id, uniqueness: { scope: [:friend_id] }

  #-- Scopes
  scope :recent,    -> { order("updated_at DESC") }


  def self.friendship_exists? (user_a, user_b)
    @friendship = Friendship.where(user_id: user_a.id, friend_id: user_b.id)
    @friendship.exists?
  end
end
