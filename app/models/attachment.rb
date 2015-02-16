class Attachment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :attachable, polymorphic: true

  #-- Callbacks
  before_save :update_attachment_attributes

  #-- Validations
  #validates_presence_of :contents


  #-- Mount uploader for the content field
  mount_uploader :contents, AttachmentUploader

private
  #-- Update 
  def update_attachment_attributes
    if contents.present? && contents_changed?
      self.content_type = contents.file.content_type
      self.file_size = contents.file.size
    end
  end
end
