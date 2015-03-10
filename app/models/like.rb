class Like < ActiveRecord::Base
  #-- Associations
  belongs_to :likeable, polymorphic: true
  belongs_to :liker, class_name: "User"
  #-- Validations
  validates :liker_id, uniqueness: { scope: [:likeable_id, :likeable_type] }
  #-- Scopes
  scope :guides,      -> { where(likeable_type: "Guide") }
  scope :attachments, -> { where(likeable_type: "Attachment") }
end