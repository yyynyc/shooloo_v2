class AddCategoryAgain < ActiveRecord::Migration
  def up
  	add_column :posts, :category, :string
  end

  def down
  	remove_column :posts, :category, :string
  end
end
