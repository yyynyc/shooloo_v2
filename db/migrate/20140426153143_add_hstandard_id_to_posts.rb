class AddHstandardIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :hstandard_id, :integer
  end
end
