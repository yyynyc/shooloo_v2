class AddToResponses < ActiveRecord::Migration
  def change
  	add_index :responses, [:assignee_id, unique: true
  end
end
