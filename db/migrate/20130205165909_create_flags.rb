class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
    	t.text :name
    	t.integer :rating_id

      t.timestamps
    end
  end
end
