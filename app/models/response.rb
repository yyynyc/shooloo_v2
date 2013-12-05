class Response < ActiveRecord::Base
  attr_accessible :assignment_id, :assignee_id, :grade_id,
  	:completed, :graded

  belongs_to :assignee, class_name: "User"
  belongs_to :assignment
  belongs_to :grade
  belongs_to :trackable, polymorphic: true

  has_many :comments, dependent: :destroy
  has_many :gradings, through: :comments
  has_many :posts, dependent: :destroy
  has_many :gradings, through: :posts

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
