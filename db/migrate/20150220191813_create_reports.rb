class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :reporter, index: true
      t.references :reportable, polymorphic: true, index: true
      t.string :title
      t.text :reason, null: false, length: { minimum: 50 }
      t.timestamps
    end
  end
end
