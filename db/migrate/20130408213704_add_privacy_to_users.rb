class AddPrivacyToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :privacy, :boolean
  	add_column :users, :rules, :boolean
  end

  def down
  	remove_column :users, :privacy, :boolean
  	remove_column :users, :rules, :boolean
  end
end
