class AddPositionToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :position, :integer
  end
end
