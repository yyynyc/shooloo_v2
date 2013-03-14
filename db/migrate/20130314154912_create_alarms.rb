class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.integer :alarmed_post_id
      t.integer :alarmed_comment_id
      t.integer :alarmer_id

      t.timestamps
    end
    add_index :alarms, :alarmed_post_id
    add_index :alarms, :alarmed_comment_id
    add_index :alarms, :alarmer_id
  end
end
