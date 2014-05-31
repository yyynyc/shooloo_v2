class CreateAlarmReasons < ActiveRecord::Migration
  def change
    create_table :alarm_reasons do |t|
      t.integer :alarm_id
      t.integer :reason_id

      t.timestamps
    end
  end
end
