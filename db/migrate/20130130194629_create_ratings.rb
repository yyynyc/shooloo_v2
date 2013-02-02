class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :rater_id
      t.string :rated_post_id
      t.integer :value

      t.timestamps
    end

    add_index :ratings, :rater_id
    add_index :ratings, :rated_post_id
  end
end
