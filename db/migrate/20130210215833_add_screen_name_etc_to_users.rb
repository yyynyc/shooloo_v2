class AddScreenNameEtcToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :screen_name, :string
  	add_column :users, :grade, :string
  	add_column :users, :last_name, :string
  end
end
