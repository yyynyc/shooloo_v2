class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :level_id
      t.string :name
      t.string :symbol
      t.string :core

      t.timestamps
    end
  end
end
