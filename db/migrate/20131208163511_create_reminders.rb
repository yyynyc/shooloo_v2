class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :teacher_id
      t.integer :reminded_response_id
      t.integer :remindee_id

      t.timestamps
    end
  end
end
