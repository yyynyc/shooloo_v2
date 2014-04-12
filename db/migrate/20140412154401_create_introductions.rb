class CreateIntroductions < ActiveRecord::Migration
  def change
    create_table :introductions do |t|
      t.integer :introducer_id
      t.integer :introducee_id
      t.string :introducer_email

      t.timestamps
    end
  end
end
