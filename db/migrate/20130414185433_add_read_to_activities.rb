class AddReadToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :read, :boolean
  end

  def down
    remove_column :activities, :read, :boolean
  end
end
