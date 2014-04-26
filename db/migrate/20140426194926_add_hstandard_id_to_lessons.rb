class AddHstandardIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :hstandard_id, :integer
  end
end
