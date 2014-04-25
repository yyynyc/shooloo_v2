class AddPubcredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pubcred, :integer, default: 0
    add_column :users, :correction_count, :integer, default: 0
  end
end
