class AddQuestionScoresToRatings < ActiveRecord::Migration
  def change
  	add_column :ratings, :answer_correctness, :integer
  	add_column :ratings, :steps, :integer
  	add_column :ratings, :grade_suitability, :integer
    #add_column :ratings, :operations, :integer
    #add_column :ratings, :improvements, :integer
    #add_column :ratings, :flags, :integer
  	
    #add_column :ratings, :vocabulary, :boolean
    #add_column :ratings, :grammer, :boolean
    #add_column :ratings, :concept_clarity, :boolean
    #add_column :ratings, :plagerism, :boolean
    #add_column :ratings, :image_offensive, :boolean
    #add_column :ratings, :language_offensive, :boolean
  end
end
