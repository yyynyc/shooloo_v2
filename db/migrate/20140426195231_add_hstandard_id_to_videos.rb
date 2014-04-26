class AddHstandardIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :hstandard_id, :integer
  end
end
