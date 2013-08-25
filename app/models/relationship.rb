class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create do    
    Activity.create!(action: "create", trackable: self, 
    	user_id: self.follower_id, recipient_id: self.followed_id)
    Event.create!(benefactor_id: self.follower_id, beneficiary_id: self.followed_id, 
        event: "follow", value: ShoolooV2::FOLLOW)
  end

  after_destroy do
  	Event.create!(benefactor_id: self.follower_id, beneficiary_id: self.followed_id, 
        event: "unfollow", value: ShoolooV2::UNFOLLOW)
  end
end
