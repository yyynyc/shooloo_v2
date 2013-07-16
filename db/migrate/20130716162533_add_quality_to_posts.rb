class AddQualityToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :quality_id, :integer
  end
end
