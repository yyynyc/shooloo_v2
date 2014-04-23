class AddStateToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :state, :string
  	add_index :posts, :state
  	add_column :posts, :competition, :integer
  	add_column :posts, :qualified, :string
  	add_column :posts, :steps, :integer
  end
end
