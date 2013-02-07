class AddIndexToRatings < ActiveRecord::Migration
  def change
  	add_index :ratings, [:rater_id, :rated_post_id], unique: true
  end
end
