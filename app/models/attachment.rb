class Attachment < ActiveRecord::Base
  #-- Associations
  belongs_to :user
  belongs_to :attachable, polymorphic: true
  has_many :reports, as: :reportable, dependent: :destroy
  
  #-- Paperclip attachment
  has_attached_file :upload
  do_not_validate_attachment_file_type :upload

  validates_presence_of :upload
end
