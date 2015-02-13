class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :user, index: true
      t.string :course_code, index: true
      t.text :description
      t.timestamps
    end
  end
end
