class Nudge < ActiveRecord::Base
  attr_accessible :nudged_id, :nudger_id

  belongs_to :nudger, class_name: "User"
  belongs_to :nudged, class_name: "User"

  validates :nudger_id, presence: true
  validates :nudged_id, presence: true

  after_create do
    Activity.create!(action: "create", trackable: self, 
    	user_id: self.nudger_id, recipient_id: self.nudged_id)
    Event.create!(benefactor_id: self.nudger_id, beneficiary_id: self.nudged_id, 
        event: "nudge", value: ShoolooV2::NUDGE)
  end

    def self.destroy_old_data
  		delete_all(['created_at < ?', 7.days.ago])
  	end
end	
