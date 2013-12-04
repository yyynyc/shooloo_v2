class AddToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :start_date, :date
  	add_column :assignments, :end_date, :date
  end
end
