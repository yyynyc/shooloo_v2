class AddViewsToCorrections < ActiveRecord::Migration
  def change
    add_column :corrections, :author_views, :integer, default: 0
    add_column :corrections, :other_views, :integer, default: 0
  end
end
