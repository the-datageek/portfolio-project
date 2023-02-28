class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :user_id, nulll: false

      t.timestamps
    end
  end
end
