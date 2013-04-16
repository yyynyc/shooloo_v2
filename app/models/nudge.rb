class Nudge < ActiveRecord::Base
  attr_accessible :nudged_id, :nudger_id

  belongs_to :nudger, class_name: "User"
  belongs_to :nudged, class_name: "User"

  validates :nudger_id, presence: true
  validates :nudged_id, presence: true

  after_create do
    Activity.create!(action: "create", trackable: self, 
    	user_id: self.nudger_id, recipient_id: self.nudged_id)
  end

end	
