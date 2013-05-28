class RefCheck < ActiveRecord::Base
	attr_accessible :avatar_appropriate, :name_true, 
	  	:role_true, :screen_name_appropriate,
	  	:referral_id
	belongs_to :referral
	validates_presence_of :referral_id
	validates_inclusion_of :name_true, :role_true,  
		:avatar_appropriate, 
	  	:screen_name_appropriate,
	  	in: [true, false]

	after_create do 
		if self.name_true == true &&
			self.role_true == true &&
			self.screen_name_appropriate == true &&
			self.avatar_appropriate == true
			self.referral.update_attributes!(approval: "accepted")
		elsif self.name_true == false ||
			self.role_true == false ||
			self.screen_name_appropriate == false ||
			self.avatar_appropriate == false
			self.referral.update_attributes!(approval: "declined")
		end
	end

	after_destroy do
		self.referral.update_attributes!(approval: "pending")
	end
end
