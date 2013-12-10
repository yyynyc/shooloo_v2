class AddGradedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :graded, :boolean, default: false

    Post.reset_column_information
  	Post.all.each do |p|
  		if p.grading.nil?
  			p.graded = false
  			p.save(validate: false)
  		else 
  			p..graded = true
  			p.save(validate: false)
  		end
  	end
  end
end
