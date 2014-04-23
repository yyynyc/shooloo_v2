class CreateCorrections < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.integer :editor_id
      t.integer :corrected_post_id
      t.integer :competition
      t.text :question
      t.text :answer
      t.integer :steps
      t.integer :level_id
      t.integer :domain_id
      t.integer :standard_id
      t.boolean :grammar
      t.boolean :concept_clear
      t.boolean :math_correct
      t.boolean :answer_complete

      t.timestamps
    end
    add_index :corrections, :corrected_post_id, uniqueness: true
  end
end
