class Invite < ActiveRecord::Base
  attr_accessible :invitee_id, :inviter_id, :post_id

  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"
  belongs_to :post

  validates_presence_of :inviter_id, :post_id

  after_create do
  	unless self.inviter == self.post.user
  		Activity.create!(action: "notify", trackable: self, 
			user_id: self.inviter_id, recipient_id: self.post.user_id)
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
