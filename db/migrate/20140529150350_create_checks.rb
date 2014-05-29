class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.integer :checker_id
      t.integer :checked_post_id

      t.timestamps
    end
    add_index :checks, :checked_post_id, uniqueness: true
  end
end
