class CreateStudentContests < ActiveRecord::Migration
  def change
    create_table :student_contests do |t|
      t.integer :user_id
      t.integer :entry_total, default: 0
      t.integer :qualified_total, default: 0
      t.integer :disqualified_total, default: 0

      t.timestamps
    end
    add_index :student_contests, :user_id, uniqueness: true
  end
end
