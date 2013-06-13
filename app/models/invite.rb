class Invite < ActiveRecord::Base
  attr_accessible :inviter_id, :invited_post_id

  belongs_to :inviter, class_name: "User" 
  belongs_to :invited_post, class_name: "Post"

  validates_presence_of :inviter_id, :invited_post_id

  after_create do
  	unless self.inviter == self.invited_post.user
  		Activity.create!(action: "notify", trackable: self, 
			user_id: self.inviter_id, recipient_id: self.invited_post.user_id)
      Event.create!(benefactor_id: self.inviter_id, 
        beneficiary_id: self.invited_post.user_id, 
        event: "invite to comment others' post", value: ShoolooV2::INVITE_COMMENT)
  	end
  	if self.inviter.admin?
  		User.all.each do |u|
  			Activity.create!(action: "create", trackable: self, 
  				user_id: self.inviter_id, recipient_id: u.id)
  		end
  	elsif self.inviter.role == "teacher" && self.inviter.authorized_users.any?
  		self.inviter.authorized_users.each do |u|
  			Activity.create!(action: "create", trackable: self, 
  				user_id: self.inviter_id, recipient_id: u.id)
  		end
  	else
  		self.inviter.followers.each do |u|	
  			Activity.create!(action: "create", trackable: self, 
  				user_id: self.inviter_id, recipient_id: u.id)
  		end
  	end 	
  end
end
