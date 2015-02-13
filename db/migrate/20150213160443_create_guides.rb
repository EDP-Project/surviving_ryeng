class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.references :course, index: true
      t.references :user, index: true
      t.string :title, index: true
      t.text :content, null: false
      t.boolean :approved, index: true
      t.integer :likes
      t.integer :dislikes
      t.timestamps
    end
  end
end
