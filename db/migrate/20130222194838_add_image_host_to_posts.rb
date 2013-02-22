class AddImageHostToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_host, :string
  end
end
