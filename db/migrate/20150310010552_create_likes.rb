class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, index: true
      t.references :liker, index: true
      t.timestamps
    end
  end
end
