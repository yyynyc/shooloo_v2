class AddHstandardIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :hstandard_id, :integer
  end
end
