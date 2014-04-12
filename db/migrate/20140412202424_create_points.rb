class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :advocacy, default: 0
      t.integer :inspiration, default: 0
      t.integer :education, default: 0
      t.integer :competition, default: 0

      t.timestamps
    end
  end
end
