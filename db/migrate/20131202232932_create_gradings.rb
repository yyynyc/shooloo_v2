class CreateGradings < ActiveRecord::Migration
  def change
    create_table :gradings do |t|
      t.integer :graded_post_id
      t.integer :graded_comment_id
      t.integer :grader_id
      t.integer :level_id
      t.integer :domain_id
      t.integer :standard_id
      t.boolean :concept
      t.boolean :precision
      t.boolean :computation
      t.boolean :grammar
      t.boolean :courtesy
      t.text  :note

      t.timestamps
    end
  end
end
