class AddedIndexToAuthorizations < ActiveRecord::Migration
  def up
  	add_index :authorizations, [:authorizer_id, :authorized_id], unique: true
  end

  def down
  	remove_index :authorizations, [:authorizer_id, :authorized_id]
  end
end
