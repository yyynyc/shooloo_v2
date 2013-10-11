class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :post_a_id
      t.integer :post_b_id
      t.text :description
      t.integer :user_id
      t.integer :level_id
      t.integer :domain_id
      t.integer :standard_id

      t.timestamps
    end
  end
end
