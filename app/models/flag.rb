# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  name       :text
#  rating_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

class Flag < ActiveRecord::Base
	attr_accessible :rating_id, :name, :position
  	belongs_to :rating

  	#attr_accessible :name
  	#belongs_to :post
  	#belongs_to :user

  	#after_create do 
  		#Post.update_all('visible=false',['id=?',self.post_id])
  		
  	#end
end
