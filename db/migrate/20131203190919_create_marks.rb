class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :mark, default: 0
      t.string :bonus
      t.string :penalty
      t.integer :grading_id
      t.timestamps
    end
  end
end
