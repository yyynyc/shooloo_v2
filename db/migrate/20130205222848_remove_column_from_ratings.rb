class RemoveColumnFromRatings < ActiveRecord::Migration
  def up
  	remove_column :ratings, :value
  end

  def down
  	add_column :ratings, :value
  end
end
