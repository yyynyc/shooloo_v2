class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :symbol

      t.timestamps
    end
  end
end
