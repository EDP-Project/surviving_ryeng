class Attachment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :attachable, polymorphic: true

  #-- Paperclip attachment
  has_attached_file :upload, path: ":rails_root/public/attachments/:id/:filename"
  do_not_validate_attachment_file_type :upload

  #-- Callbacks
  #before_save :update_attachment_attributes

  #-- Validations
  #validates_presence_of :contents

private
  #-- Update 
  # def update_attachment_attributes
  #   if contents.present? && contents_changed?
  #     self.content_type = contents.file.content_type
  #     self.file_size = contents.file.size
  #   end
  # end
end
