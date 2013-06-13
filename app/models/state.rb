class State < ActiveRecord::Base
  attr_accessible :complete, :user_id
  belongs_to :user

  after_create do
  	Event.create!(benefactor_id: self.user_id, beneficiary_id: 2, 
      event: "complete user profile", value: ShoolooV2::PROFILE_COMPLETE)
  end
end
