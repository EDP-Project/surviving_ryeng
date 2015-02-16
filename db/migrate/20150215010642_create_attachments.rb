class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :user, index: true
      t.references :attachable, polymorphic: true, index: true
      t.integer :download_count, default: 0
      t.integer :likes, default: 0
      t.integer :likes, default: 0
      t.timestamps
    end
  end
end
