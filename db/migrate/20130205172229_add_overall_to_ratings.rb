class AddOverallToRatings < ActiveRecord::Migration
  def change
  	add_column :ratings, :overall_rating, :boolean, default: false
  end
end
