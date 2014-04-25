class AddHstandardToCorrections < ActiveRecord::Migration
  def change
    add_column :corrections, :hstandard_id, :integer
  end
end
