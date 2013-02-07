class CreateImprovements < ActiveRecord::Migration
  def change
    create_table :improvements do |t|
    	t.text :name
    	t.integer :rating_id

      t.timestamps
    end
  end
end
