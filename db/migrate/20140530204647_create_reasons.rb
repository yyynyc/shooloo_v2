class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.integer :position
      t.string :name
      t.integer	:alarm_id

      t.timestamps
    end
  end
end
