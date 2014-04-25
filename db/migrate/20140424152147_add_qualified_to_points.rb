class AddQualifiedToPoints < ActiveRecord::Migration
  def change
    add_column :points, :qualified, :integer, default: 0
    add_column :points, :disqualified, :integer, default: 0
  end
end
