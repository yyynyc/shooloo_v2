class AddToreviewToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :toreview, :boolean
  end
end
