class CreateReferrals < ActiveRecord::Migration
  def up
    create_table :referrals do |t|
    	t.integer :referred_id
    	t.integer :referrer_id
    	t.boolean :approval, default: false

      t.timestamps
    end
    add_index :referrals, :referred_id
    add_index :referrals, :referrer_id
  end

  def down
  	remove_table :referrals
  	remove_index :referrals, :referred_id
    remove_index :referrals, :referrer_id
  end
end
