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
  end
end
