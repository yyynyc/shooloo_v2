class State < ActiveRecord::Base
  attr_accessible :complete, :user_id
  belongs_to :user

  after_create do
  	Event.create!(benefactor_id: self.user_id, beneficiary_id: 1, 
      event: "complete user profile", value: ShoolooV2::PROFILE_COMPLETE)
  	Activity.create!(action: "create", trackable: self, 
        user_id: self.user_id, recipient_id: 2)
  	if self.user.role == "student" && !self.user.parent_email.blank?
  		UserMailer.parental_consent(self.user).deliver
  	end
  end
end
