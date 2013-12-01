class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :assigner_id
      t.integer :level_id
      t.integer :domain_id
      t.integer :standard_id
      t.integer :assigned_post_id
      t.text  :instruction

      t.timestamps
    end
  end
end
