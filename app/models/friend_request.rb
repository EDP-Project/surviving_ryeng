class FriendRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :receiver, class_name: 'User'

  validates :user_id, uniqueness: { scope: [:receiver_id] }

  def self.cleanup(uid1, uid2)
    @requests = FriendRequest.where("user_id = ? OR receiver_id = ?", uid1, uid2)
    @requests.destroy_all if @requests.any?
  end
end
