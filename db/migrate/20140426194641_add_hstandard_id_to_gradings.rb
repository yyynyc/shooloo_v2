class AddHstandardIdToGradings < ActiveRecord::Migration
  def change
    add_column :gradings, :hstandard_id, :integer
  end
end
