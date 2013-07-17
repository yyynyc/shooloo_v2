class AddSubjectToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :subject_id, :integer
  end
end
