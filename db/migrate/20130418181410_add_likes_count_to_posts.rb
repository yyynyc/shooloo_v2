class AddLikesCountToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :likes_count, :integer
  end

  def down
  	remove_column :posts, :likes_count, :integer
  end
end
