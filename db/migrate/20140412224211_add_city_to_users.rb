class AddCityToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :address_city, :string
  	add_column :users, :address_state, :string
  	add_index :users, :personal_email, uniqueness: true
  end
end
