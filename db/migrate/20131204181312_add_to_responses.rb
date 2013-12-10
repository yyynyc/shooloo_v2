class AddToResponses < ActiveRecord::Migration
  def change
  	add_column :responses, :graded, :boolean
  end
end
