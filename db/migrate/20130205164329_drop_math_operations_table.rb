class DropMathOperationsTable < ActiveRecord::Migration
  def up
  	drop_table :math_operations
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end

   