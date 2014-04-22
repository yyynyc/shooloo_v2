class AddStateToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :state, :string
  	add_index :posts, :state
  end
end
