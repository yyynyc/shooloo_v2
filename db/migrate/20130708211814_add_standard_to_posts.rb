class AddStandardToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :grade_id, :integer
  	add_column :posts, :domain_id, :integer
  	add_column :posts, :standard_id, :integer
  end
end
