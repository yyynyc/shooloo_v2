class AddLikesCountToComments < ActiveRecord::Migration
  def up
    add_column :comments, :likes_count, :integer
  end

  def down
  	remove_column :comments, :likes_count, :integer
  end
end
