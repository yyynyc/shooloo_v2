class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
    	t.integer :authorized_id
    	t.integer :authorizer_id
    	t.string :approval, default: "pending"

      t.timestamps
    end
    add_index :authorizations, :authorized_id
    add_index :authorizations, :authorizer_id
  end
end
