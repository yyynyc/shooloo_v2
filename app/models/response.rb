class Response < ActiveRecord::Base
  attr_accessible :assignment_id, :assignee_id, :grade_id, 
  	:trackable_id, :trackable_type

  belongs_to :assignee, class_name: "User"
  belongs_to :assignments
  belongs_to :grade
  belongs_to :trackable, polymorphic: true
  
end
