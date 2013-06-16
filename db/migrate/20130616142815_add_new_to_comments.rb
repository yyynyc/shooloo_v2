class AddNewToComments < ActiveRecord::Migration
  def change
    add_column :comments, :new_comment, :boolean
  end
end
