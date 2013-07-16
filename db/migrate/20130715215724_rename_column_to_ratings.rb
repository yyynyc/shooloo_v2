class RenameColumnToRatings < ActiveRecord::Migration
  def up
  	rename_column :ratings, :grade_suitability, :ccss_suitability
  end

  def down
  end
end
