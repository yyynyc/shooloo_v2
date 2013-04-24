class AddPostsCountsEtcToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :posts_count, :integer
  	add_column :users, :rated_posts_count, :integer
  	add_column :users, :commented_posts_count, :integer
  	add_column :users, :followers_count, :integer
  	add_column :users, :followed_users_count, :integer
  end

  def down
  	remove_column :users, :posts_count, :integer
  	remove_column :users, :rated_posts_count, :integer
  	remove_column :users, :commented_posts_count, :integer
  	remove_column :users, :followers_count, :integer
  	remove_column :users, :followed_users_count, :integer
  end
end
