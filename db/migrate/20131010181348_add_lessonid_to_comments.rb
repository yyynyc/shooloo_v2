class AddLessonidToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commented_lesson_id, :integer
  end
end
