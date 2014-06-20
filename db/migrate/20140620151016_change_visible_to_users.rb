class ChangeVisibleToUsers < ActiveRecord::Migration
  def up
  	change_column :users, :visible, :boolean, default: true
  end

  def down
  end
end
