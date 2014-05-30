
class Activity < ActiveRecord::Base
	attr_accessible :action, :trackable, :recipient_id, :user_id, :read, :position
  	belongs_to :trackable, polymorphic: true
  	belongs_to :user 

  	def self.destroy_old_data
  		unless self.trackable_type=="Post" && self.action.in?(["qualify", "notify", "at_grade", "below_grade", "publish"])
  			delete_all(['created_at < ?', 30.days.ago])
  		end
  	end


  	def recipient
  		User.find(self.recipient_id)
  	end
end
