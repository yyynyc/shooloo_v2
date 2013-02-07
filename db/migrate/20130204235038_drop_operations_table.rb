class DropOperationsTable < ActiveRecord::Migration
  def up 
  	drop_table :operations
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
