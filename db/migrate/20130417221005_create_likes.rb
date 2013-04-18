class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.integer :liked_post_id
	    t.integer :liked_comment_id
	    t.integer :liker_id
	    t.timestamps
    end
    add_index :likes, :liked_post_id
    add_index :likes, :liked_comment_id
    add_index :likes, :liker_id
  end
end
