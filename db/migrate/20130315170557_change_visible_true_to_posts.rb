class ChangeVisibleTrueToPosts < ActiveRecord::Migration
  def up
  	change_column :posts, :visible, :boolean, default: true
  end

  def down
  end
end
