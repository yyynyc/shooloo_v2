class AddGradeeIdToGradings < ActiveRecord::Migration
  def change
    add_column :gradings, :gradee_id, :integer
  end
end
