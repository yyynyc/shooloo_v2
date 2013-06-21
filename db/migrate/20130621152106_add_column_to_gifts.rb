class AddColumnToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :sent_week, :integer
    add_column :gifts, :sent_year, :integer
  end
end
