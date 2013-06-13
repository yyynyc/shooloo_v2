class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :week
      t.integer :benefactor_id
      t.integer :beneficiary_id
      t.integer :weekly_tally

      t.timestamps
    end
  end
end
