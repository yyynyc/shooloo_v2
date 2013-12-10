class AddToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :response_id, :integer
  end
end
