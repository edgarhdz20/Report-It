class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
      t.string :description
      t.float :pos_x
      t.float :pos_y
      t.string :address

      t.timestamps null: false
    end
  end
end
