class AddPositionToImprovements < ActiveRecord::Migration
  def change
  	add_column :improvements, :position, :integer
  end
end
