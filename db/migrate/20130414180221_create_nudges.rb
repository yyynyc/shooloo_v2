class CreateNudges < ActiveRecord::Migration
  def change
    create_table :nudges do |t|
      t.integer :nudger_id
      t.integer :nudged_id

      t.timestamps
    end
  end
end
