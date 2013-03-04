class AddDetailsToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :answer_correctness_2_count, :integer 
  	add_column :posts, :answer_correctness_3_count, :integer
  	add_column :posts, :answer_correctness_4_count, :integer
  	add_column :posts, :operation_whole_count, :integer
  end
end
