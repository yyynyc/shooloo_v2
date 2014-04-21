class RenameStatesTableToNaturesTable < ActiveRecord::Migration
  def up
  	rename_table :states, :natures
  end

  def down
  	rename_table :natures, :states
  end
end
