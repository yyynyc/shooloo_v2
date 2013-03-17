class ChangeUserToInitiatorToActivities < ActiveRecord::Migration
  def up
  	rename_column :activities, :user_id, :initiator_id
  	add_column :activities, :recipient_id, :integer
  end

  def down
  end
end
