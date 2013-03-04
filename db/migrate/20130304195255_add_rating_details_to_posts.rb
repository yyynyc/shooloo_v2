class AddRatingDetailsToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :ratings_count, :integer
  	add_column :posts, :overall_true_count, :integer
  	add_column :posts, :overall_false_count, :integer
  	add_column :posts, :grade_below_count, :integer
  	add_column :posts, :grade_right_count, :integer
  	add_column :posts, :grade_above_count, :integer
  	add_column :posts, :steps_1_count, :integer
  	add_column :posts, :steps_2_count, :integer
  	add_column :posts, :steps_3_count, :integer
  	add_column :posts, :steps_4_count, :integer
  	add_column :posts, :steps_5_count, :integer
  	add_column :posts, :steps_6_count, :integer  	
  	add_column :posts, :operation_decimal_count, :integer
  	add_column :posts, :operation_fraction_count, :integer
  	add_column :posts, :operation_percentage_count, :integer
  	add_column :posts, :operation_negative_count, :integer
  	add_column :posts, :operation_addition_count, :integer
  	add_column :posts, :operation_substraction_count, :integer
  	add_column :posts, :operation_multiplication_count, :integer
  	add_column :posts, :operation_division_count, :integer
  	add_column :posts, :vocabulary_count, :integer
  	add_column :posts, :grammar_count, :integer
  	add_column :posts, :structure_count, :integer
  	add_column :posts, :clarity_count, :integer
  	add_column :posts, :originality_count, :integer
  	add_column :posts, :plagerism_count, :integer
  	add_column :posts, :content_count, :integer
  	add_column :posts, :image_count, :integer
  end
end
