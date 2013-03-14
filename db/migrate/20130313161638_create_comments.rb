class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :content
    	t.attachment :photo
      t.integer :commenter_id
      t.integer :commented_post_id
      t.timestamps      	
    end
    add_index :comments, [:commenter_id, :created_at]
  end
end
