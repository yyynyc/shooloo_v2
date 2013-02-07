class AddColumnToOperations < ActiveRecord::Migration
  def change
  	add_column :operations, :rating_id, :integer
  end
end
