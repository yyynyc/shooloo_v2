class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :assignee_id
      t.integer :grade_id
      t.integer :assignment_id
      t.belongs_to :trackable
      t.string :trackable_type

      t.timestamps
    end

    add_index :responses, [:assignment_id, :assignee_id], unique: true
  end
end
