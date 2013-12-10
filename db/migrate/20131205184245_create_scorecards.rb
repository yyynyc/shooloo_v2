class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
    	t.integer :response_id
      	t.integer :color_id

      t.timestamps
    end

    add_index :scorecards, :response_id
  end
end
