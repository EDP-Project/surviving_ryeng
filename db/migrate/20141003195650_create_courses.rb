class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user, index: true
      t.string :course_code, index: true
      t.text :description, index: true	
      t.timestamps
    end
  end
end
