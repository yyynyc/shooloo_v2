class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, uniqueness: true
  end
end
