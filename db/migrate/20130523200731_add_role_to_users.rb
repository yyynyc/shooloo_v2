class AddRoleToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string, default: "student"
    add_column :users, :auth_req_count, :integer, default: 0
    add_column :users, :auth_status, :string
  end

  def down
  	remove_column :users, :role
  	remove_column :users, :auth_req_count
  	remove_column :users, :auth_status
  end
end
