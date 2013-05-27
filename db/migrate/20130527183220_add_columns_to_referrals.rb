class AddColumnsToReferrals < ActiveRecord::Migration
  def up
    add_column :referrals, :name_true, :boolean
    add_column :referrals, :role_true, :boolean
    add_column :referrals, :screen_name_appropriate, :boolean
    add_column :referrals, :avatar_appropriate, :boolean
  end

  def down
  	remove_column :referrals, :name_true
    remove_column :referrals, :role_true
    remove_column :referrals, :screen_name_appropriate
    remove_column :referrals, :avatar_appropriate
  end
end
