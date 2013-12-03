class CreateGradings < ActiveRecord::Migration
  def change
    create_table :gradings do |t|
      t.integer :post_id
      t.integer :comment_id
      t.integer :grader_id
      t.integer :mark, default: 0
      t.integer :bonus, default: 0
      t.integer :level_id
      t.integer :domain_id
      t.integer :standard_id
      t.boolean :concept
      t.boolean :precision
      t.boolean :computation
      t.boolean :grammar
      t.boolean :courtesy

      t.timestamps
    end
  end
end
