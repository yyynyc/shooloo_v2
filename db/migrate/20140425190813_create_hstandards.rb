class CreateHstandards < ActiveRecord::Migration
  def change
    create_table :hstandards do |t|
      t.integer :standard_id
      t.integer :domain_id
      t.integer :level_id
      t.text :symbol
      t.text :short
      t.text :url
      t.text :description
      t.text :ICan

      t.timestamps
    end
  end
end
