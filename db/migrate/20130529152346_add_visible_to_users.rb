class AddVisibleToUsers < ActiveRecord::Migration
  def up
    add_column :users, :visible, :boolean, default: false
  end

  def down
  	remove_column :users, :visible
  end
end
