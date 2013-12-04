class AddToGradings < ActiveRecord::Migration
  def change
  	add_index :gradings, [:grader_id, :graded_post_id], unique: true
  	add_index :gradings, [:grader_id, :graded_comment_id], unique: true
  	add_index :gradings, :grader_id
  	add_index :gradings, :graded_post_id
  	add_index :gradings, :graded_comment_id
  end
end
