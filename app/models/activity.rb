class Activity < ActiveRecord::Base
	attr_accessible :action, :trackable
  	belongs_to :trackable, polymorphic: true
  	belongs_to :user

  	#belongs_to :initiator, class_name: "User"
  	#belongs_to :recipient, class_name: "User"
  
end
