class RemoveColumnsFromPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :ratings_count
  	remove_column :posts, :category
  	remove_column :posts, :answer_correctness_1_count
  	remove_column :posts, :answer_correctness_2_count
  	remove_column :posts, :answer_correctness_3_count
  	remove_column :posts, :answer_correctness_4_count
  	remove_column :posts, :operation_whole_count
  	remove_column :posts, :overall_true_count
  	remove_column :posts, :overall_false_count
  	remove_column :posts, :ccss_right_count
  	remove_column :posts, :steps_1_count
  	remove_column :posts, :steps_2_count
  	remove_column :posts, :steps_3_count
  	remove_column :posts, :steps_4_count
  	remove_column :posts, :steps_5_count
  	remove_column :posts, :steps_6_count
  	remove_column :posts, :vocabulary_count
  	remove_column :posts, :grammar_count
  	remove_column :posts, :structure_count
  	remove_column :posts, :clarity_count
  	remove_column :posts, :originality_count
  	remove_column :posts, :ccss_wrong_grade_count
  	remove_column :posts, :ccss_wrong_skill_count
  	remove_column :posts, :ccss_wrong_ican_count
  end
end
