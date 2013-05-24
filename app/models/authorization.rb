class Authorization < ActiveRecord::Base
  attr_accessible :authorizer_id, :approval

  belongs_to :authorized, class_name: "User"
  belongs_to :authorizer, class_name: "User"

  validates_presence_of :authorized_id, :authorizer_id, :approval

#	after_create :update_teacher_auth_req_count 
  	
#  def update_teacher_auth_req_count 
#  	@teacher = User.find(self.authorizer.id)
#  	@teacher.auth_req_count += 1
#   @teacher.save!
#  end

#  after_create do
#    Activity.create!(action: "create", trackable: self, 
#    	user_id: self.authorized_id, recipient_id: self.authorizer_id)
#  end
end
