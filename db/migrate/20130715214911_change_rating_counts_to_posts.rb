class ChangeRatingCountsToPosts < ActiveRecord::Migration
  def up
  	remove_column :posts, :grade_below_count
  	remove_column :posts, :grade_above_count	
  	remove_column :posts, :operation_decimal_count
  	remove_column :posts, :operation_fraction_count
  	remove_column :posts, :operation_percentage_count
  	remove_column :posts, :operation_negative_count
  	remove_column :posts, :operation_addition_count
  	remove_column :posts, :operation_substraction_count
  	remove_column :posts, :operation_multiplication_count
  	remove_column :posts, :operation_division_count
  	remove_column :posts, :plagerism_count
  	remove_column :posts, :content_count
  	remove_column :posts, :image_count
  	rename_column :posts, :grade_right_count, :ccss_right_count
  	add_column :posts, :ccss_wrong_grade_count, :integer
  	add_column :posts, :ccss_wrong_skill_count, :integer
  	add_column :posts, :ccss_wrong_ican_count, :integer
  end

  def down
  	add_column :posts, :grade_below_count, :integer
  	add_column :posts, :grade_above_count, :integer	
  	add_column :posts, :operation_decimal_count, :integer
  	add_column :posts, :operation_fraction_count, :integer
  	add_column :posts, :operation_percentage_count, :integer
  	add_column :posts, :operation_negative_count, :integer
  	add_column :posts, :operation_addition_count, :integer
  	add_column :posts, :operation_substraction_count, :integer
  	add_column :posts, :operation_multiplication_count, :integer
  	add_column :posts, :operation_division_count, :integer
  	add_column :posts, :plagerism_count, :integer
  	add_column :posts, :content_count, :integer
  	add_column :posts, :image_count, :integer
  	rename_column :posts, :ccss_right_count, :grade_right_count 
  	remove_column :posts, :ccss_wrong_grade_count
  	remove_column :posts, :ccss_wrong_skill_count
  	remove_column :posts, :ccss_wrong_ican_count
  end
end
