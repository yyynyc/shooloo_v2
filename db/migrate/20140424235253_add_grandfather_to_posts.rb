class AddGrandfatherToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :grandfather, :boolean
  end
end
