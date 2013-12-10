class CreateKeeps < ActiveRecord::Migration
  def change
    create_table :keeps do |t|
      t.integer :keeper_id
      t.integer :kept_post_id
      t.text :note

      t.timestamps
    end
    add_index :keeps, :keeper_id
    add_index :keeps, :kept_post_id
    add_index :keeps, [:keeper_id, :kept_post_id], unique: true
  end
end
