class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.integer :giver_id
      t.integer :receiver_id
      t.integer :week
      t.integer :year
      t.integer :choice
      t.boolean :sent

      t.timestamps
    end
  end
end
