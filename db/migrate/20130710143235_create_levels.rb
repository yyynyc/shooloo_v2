class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :number
      t.string :name

      t.timestamps
    end
  end
end
