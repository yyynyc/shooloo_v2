class ChangeColumnNameToGifts < ActiveRecord::Migration
  def up
  	rename_column :gifts, :choice, :choice_id
  end

  def down
  	rename_column :gifts, :choice_id, :choice
  end
end
