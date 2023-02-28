class AddCreatedAt2 < ActiveRecord::Migration[7.0]
  def change
    add_column :skills, :createdAt, :datetime
  end
end
