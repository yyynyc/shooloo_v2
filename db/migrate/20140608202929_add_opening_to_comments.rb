class AddOpeningToComments < ActiveRecord::Migration
  def change
    add_column :comments, :opening, :string
  end
end
