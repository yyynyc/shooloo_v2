class AddGradedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :graded, :boolean, default: false

    Comment.reset_column_information
  	Comment.all.each do |p|
  		if p.grading.nil?
  			p.graded = false
  			p.save(validate: false)
  		else 
  			p.graded = true
  			p.save(validate: false)
  		end
  	end
  end
end
