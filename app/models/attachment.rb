class Attachment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :attachable, polymorphic: true
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  
  #-- Scopes (mainly used for searching/sorting)
  default_scope           -> { order("updated_at DESC") }
  scope :approved,        -> { where(approved: true) }
  scope :most_downloaded, -> { order("download_count DESC") }
  scope :most_popular,    -> { order("likes DESC") }

  scope :search,          -> (q) do
                              where("description LIKE ? OR upload_file_name LIKE ?", "%#{q}%", "%#{q}%") 
                             end                           

  #-- Paperclip attachment
  has_attached_file :upload

  #validates_attachment_presence :upload
  #validates_attachment_size :upload, less_than: 26.megabyte
  #validates_attachment_content_type :upload, content_type: 
  do_not_validate_attachment_file_type :upload
  
  validates_presence_of :upload


  def like
    self.likes += 1
    current_user.liked_attachments << self unless current_user.liked_attachments.include? self
  end

  def dislike
    self.dislikes += 1
    current_user.liked_attachments.delete(self) if current_user.liked_attachments.include? self
  end
end
