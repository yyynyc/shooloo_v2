class AddPublicToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :visible, :boolean, default: true
  	add_column :videos, :position, :integer, default: 0
  	rename_column :videos, :teacher_pd, :student
  end
end
