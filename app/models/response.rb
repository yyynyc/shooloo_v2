class Response < ActiveRecord::Base
  attr_accessible :assignment_id, :assignee_id, :grade_id,
  	:completed

  belongs_to :assignee, class_name: "User"
  belongs_to :assignment
  belongs_to :grade
  belongs_to :trackable, polymorphic: true

  has_many :comments
  has_many :posts

  # validates_uniqueness_of [:assignment_id, :assignee_id]

  after_create do
  	if !self.assignee_id.nil?
  		Activity.create!(action: "assign", trackable: self, 
    		user_id: self.assignment.assigner_id, 
    		recipient_id: self.assignee_id)
  	end
  end

  after_update do

  end  
end
