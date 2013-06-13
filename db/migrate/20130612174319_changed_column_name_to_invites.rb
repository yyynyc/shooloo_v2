class ChangedColumnNameToInvites < ActiveRecord::Migration
  def up
  	rename_column :invites, :post_id, :invited_post_id
  end

  def down
  	rename_column :invites, :invited_post_id, :post_id
  end
end
