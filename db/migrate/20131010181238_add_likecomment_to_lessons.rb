class AddLikecommentToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :likes_count, :integer
    add_column :lessons, :comments_count, :integer
  end
end
