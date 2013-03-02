class AddAnswerCorrect1ToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :answer_correctness_1_count, :integer
  end
end
