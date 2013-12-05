class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
    	t.integer :value
      	t.string :code
      	t.string :weakness

      t.timestamps
    end
  end
end
