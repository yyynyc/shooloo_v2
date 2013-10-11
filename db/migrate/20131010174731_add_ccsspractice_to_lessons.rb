class AddCcsspracticeToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :practice_id, :integer
  end
end
