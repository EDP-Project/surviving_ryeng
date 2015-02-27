class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :boolean, default: false
  	add_column :users, :username, :string
  	add_column :users, :about_me, :text
    add_column :users, :banned, :boolean, default: false
  	add_index :users, :admin
  	add_index :users, :username
  end
end
