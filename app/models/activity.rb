
class Activity < ActiveRecord::Base
	attr_accessible :action, :trackable, :recipient_id, :user_id
  	belongs_to :trackable, polymorphic: true
  	belongs_to :user

  	def self.destroy_old_data
  		delete_all(['created_at < ?', 21.days.ago])
  	end
end
