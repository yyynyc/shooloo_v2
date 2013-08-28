class ChangeColumnDefaultToUsers < ActiveRecord::Migration
  def up
  	change_column :users, :post_count, :integer, default: 0
  	change_column :users, :rating_count, :integer, default: 0
  	change_column :users, :comment_count, :integer, default: 0
  	change_column :users, :follower_count, :integer, default: 0
  	change_column :users, :following_count, :integer, default: 0
  	change_column :users, :gift_received_count, :integer, default: 0
  	change_column :users, :gift_sent_count, :integer, default: 0
  end

  def down
  	change_column :users, :post_count, :integer, default: nil
  	change_column :users, :rating_count, :integer, default: 0
  	change_column :users, :comment_count, :integer, default: 0
  	change_column :users, :follower_count, :integer, default: 0
  	change_column :users, :following_count, :integer, default: 0
  	change_column :users, :gift_received_count, :integer, default: 0
  	change_column :users, :gift_sent_count, :integer, default: 0
  end
end
