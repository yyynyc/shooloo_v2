class Reminder < ActiveRecord::Base
  attr_accessible :remindee_id, :reminded_response_id, :teacher_id

  belongs_to :teacher, class_name: "User" 
  belongs_to :remindee, class_name: "User"
  belongs_to :reminded_response, class_name: "Response", counter_cache: true

  validates_presence_of :remindee_id, :reminded_response_id, :teacher_id

  after_create do
  	Activity.create!(action: "create", trackable: self, 
			user_id: self.teacher_id, recipient_id: self.remindee_id)
  end
end
