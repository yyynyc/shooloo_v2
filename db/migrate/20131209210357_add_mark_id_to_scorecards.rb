class AddMarkIdToScorecards < ActiveRecord::Migration
  def change
  	add_column :scorecards, :post_id, :integer
    add_column :scorecards, :comment_id, :integer
  end
end
