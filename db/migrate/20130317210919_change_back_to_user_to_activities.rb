class ChangeBackToUserToActivities < ActiveRecord::Migration
  def up
  	rename_column :activities, :initiator_id, :user_id
  end

  def down
  	rename_column :activities, :user_id, :initiator_id	
  end
end
