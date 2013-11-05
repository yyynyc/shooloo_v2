class ChangeColumnsToPosts < ActiveRecord::Migration
  def up
  	change_column :posts, :answer, :text
  	change_column :posts, :likes_count, :integer, default: 0
  	change_column :posts, :comments_count, :integer, default: 0
  	change_column :posts, :ratings_count, :integer, default: 0
  	change_column :posts, :overall_true_count, :integer, default: 0
  end

  def down
  end
end
