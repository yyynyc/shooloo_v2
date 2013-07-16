class CreateQualities < ActiveRecord::Migration
  def change
    create_table :qualities do |t|
      t.string :name

      t.timestamps
    end
  end
end
