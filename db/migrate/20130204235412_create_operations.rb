class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
    	t.text :name
    	t.integer :rating_id
      	t.timestamps
    end
  end
end
