
class Activity < ActiveRecord::Base
	attr_accessible :action, :trackable, :recipient_id, :user_id
  	belongs_to :trackable, polymorphic: true
  	belongs_to :user

end
