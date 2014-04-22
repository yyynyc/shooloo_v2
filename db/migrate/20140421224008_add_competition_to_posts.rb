class AddCompetitionToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :competition, :integer, default: 0
  end
end
