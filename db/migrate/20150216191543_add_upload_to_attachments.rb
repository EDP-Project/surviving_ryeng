class AddUploadToAttachments < ActiveRecord::Migration
  def self.up
    add_attachment :attachments, :upload
  end

  def self.down
    remove_attachment :attachments, :upload
  end
end
