
class Activity < ActiveRecord::Base
	attr_accessible :action, :trackable, :recipient_id, :user_id
  	belongs_to :trackable, polymorphic: true
  	belongs_to :user

  	def destroy_old_data
  		Activity.delete_all(['created_at > ?', 30.days.ago])
  	end
end
