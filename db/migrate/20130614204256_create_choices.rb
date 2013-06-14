class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :user_id	
      t.integer :gift_id
      t.string :name
      t.attachment :image
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
