class AddIndexToUsersScreenName < ActiveRecord::Migration
  def up
  	add_index :users, :screen_name, unique: true
  end

  def down
  	remove_index :users, :screen_name, unique: true
  end
end
