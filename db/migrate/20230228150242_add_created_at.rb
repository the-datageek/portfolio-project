class AddCreatedAt < ActiveRecord::Migration[7.0]
  def change
      add_column :projects, :createdAt, :datetime
  end
end
