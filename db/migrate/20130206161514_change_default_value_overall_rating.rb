class ChangeDefaultValueOverallRating < ActiveRecord::Migration
  def up
  	change_column :ratings, :overall_rating, :boolean, default: nil
  end

  def down
  	change_column :ratings, :overall_rating, :boolean, default: true
  end
end
