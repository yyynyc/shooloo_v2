class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :assignee_id
      t.integer :grading_average, default: 0
      t.integer :assignment_id
      t.boolean :completed, default: false

      t.timestamps
    end

    add_index :responses, [:assignment_id, :assignee_id], unique: true
  end
end
