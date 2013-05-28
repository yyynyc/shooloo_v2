class CreateRefChecks < ActiveRecord::Migration
  	def change
	    create_table :ref_checks do |t|
	      t.integer :referral_id
	      t.boolean :name_true
	      t.boolean :role_true
	      t.boolean :screen_name_appropriate
	      t.boolean :avatar_appropriate

	      t.timestamps
	    end
  	end	

   	def down
   		drop_table :ref_checks
   	end
end
