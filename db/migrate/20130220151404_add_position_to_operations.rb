class AddPositionToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :position, :integer
  end
end
