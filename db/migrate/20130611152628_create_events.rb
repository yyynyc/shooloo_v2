class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :benefactor_id
      t.integer :beneficiary_id
      t.string :event
      t.integer :value

      t.timestamps
    end
  end
end
