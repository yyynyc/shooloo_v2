class AddPositionToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :position, :integer, default: 0
  end
end
