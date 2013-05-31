class CreateStates < ActiveRecord::Migration
  def up
    create_table :states do |t|
      t.integer :user_id
      t.boolean :complete

      t.timestamps
    end
  end

  def down
  	drop_table :states
  end
end
