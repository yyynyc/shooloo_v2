class Assignment < ActiveRecord::Base
  attr_accessible :assigned_post_id, :assigner_id, :instruction,
  	:domain_id, :level_id, :standard_id, 
    :assignee_ids, :responses_ids

  has_many :responses, dependent: :destroy
  has_many :assignees, through: :responses
  accepts_nested_attributes_for :responses

  belongs_to :assigner, class_name: "User"
  belongs_to :assigned_post, class_name: "Post"
  belongs_to :level
  belongs_to :domain
  belongs_to :standard

  validates_presence_of :assigner_id, :level_id, :domain_id, :standard_id
  validates_associated :responses
  validates_presence_of :assignee_ids

  after_create do 
    # self.assigner.authorized_users.where(grade: self.level_id-1).each do |student|
    #   Response.create!(assignment_id: self.id, :assignee_id => student.id)
    # end
    self.assigned_post.update_attributes!(level_id: self.level_id, 
      domain_id: self.domain_id, standard_id: self.standard_id)
  end  

end
