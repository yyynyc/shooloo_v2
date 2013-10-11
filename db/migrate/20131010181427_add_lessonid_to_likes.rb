class AddLessonidToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :liked_lesson_id, :integer
  end
end
