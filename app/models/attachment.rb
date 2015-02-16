class Attachment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :attachable, polymorphic: true

  #-- Paperclip attachment
  has_attached_file :upload
  do_not_validate_attachment_file_type :upload

end
