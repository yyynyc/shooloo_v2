class ChangeApprovalValueToReferrals < ActiveRecord::Migration
  def up
  	change_column :referrals, :approval, :string, default: "pending"
  end

  def down
  	change_column :referrals, :approval, :boolean, default: nil
  end
end
