class Referral < ActiveRecord::Base
  attr_accessible :referrer_id, :approval

  belongs_to :referred, class_name: "User"
  belongs_to :referrer, class_name: "User"

  validates_presence_of :referred_id, :referrer_id, :approval

#  after_create do
#    Activity.create!(action: "create", trackable: self, 
#    	user_id: self.referred_id, recipient_id: self.referrer_id)
#  end
end
