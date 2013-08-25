class ChangeColumnNameToUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :posts_count, :post_count
  	rename_column :users, :rated_posts_count, :rating_count
  	rename_column :users, :commented_posts_count, :comment_count
  	rename_column :users, :followers_count, :follower_count
  	rename_column :users, :followed_users_count, :following_count
  	add_column :users, :gift_received_count, :integer
  	add_column :users, :gift_sent_count, :integer
  	end

  def down
  	rename_column :users, :post_count, :posts_count
  	rename_column :users, :rating_count, :rated_posts_count
  	rename_column :users, :comment_count, :commented_posts_count
  	rename_column :users, :follower_count, :followers_count
  	rename_column :users, :following_count, :followed_users_count
  	remove_column :users, :gift_received_count
  	remove_column :users, :gift_sent_count
  end
end
