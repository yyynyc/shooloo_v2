class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.integer :domain_id
      t.integer :grade_id
      t.string :symbol
      t.text :description
      t.text :ICan

      t.timestamps
    end
  end
end
