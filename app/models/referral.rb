class Referral < ActiveRecord::Base
  attr_accessible :referrer_id, :approval, :name_true, :role_true, 
  	:screen_name_appropriate, :avatar_appropriate

  belongs_to :referred, class_name: "User"
  belongs_to :referrer, class_name: "User"

  validates_presence_of :referred_id, :referrer_id, :approval

  #after_update do
  #	if self.name_true=="true" && self.role_true=="true" &&
  #		self.screen_name_appropriate=="true" &&
  #		self.avatar_appropriate=="true"
  #		self.update_attributes!(approval: "accepted")
  #	else
  #		self.update_attributes!(approval: "declined")
  #	end
  #end

#  after_create do
#    Activity.create!(action: "create", trackable: self, 
#    	user_id: self.referred_id, recipient_id: self.referrer_id)
#  end
end
