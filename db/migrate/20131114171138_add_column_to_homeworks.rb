class AddColumnToHomeworks < ActiveRecord::Migration
  def change
  	add_column :homeworks, :login_count, :integer, default: 0
  end
end
