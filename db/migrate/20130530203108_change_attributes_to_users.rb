class ChangeAttributesToUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :email, :parent_email
  	remove_column :users, :email_confirmation
  	add_column :users, :personal_email, :string
  	add_column :users, :school_name, :string
  	add_column :users, :school_url, :string
  	add_column :users, :social_media_url, :string
  	add_column :users, :email_sent_to, :string
  end

  def down
  	rename_column :users, :parent_email, :email 
  	add_column :users, :email_confirmation, :string
  	remove_column :users, :personal_email
  	remove_column :users, :school_name
  	remove_column :users, :school_url
  	remove_column :users, :social_media_url
  	remove_column :users, :email_sent_to
  end
end
