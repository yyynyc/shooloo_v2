class Assignment < ActiveRecord::Base
  attr_accessible :assigned_post_id, :assigner_id, :instruction,
  	:domain_id, :level_id, :standard_id, :assignee_level,
    :assignee_ids, :responses_ids, :start_date, :end_date

  has_many :responses, dependent: :destroy
  has_many :assignees, through: :responses
  accepts_nested_attributes_for :responses

  has_many :scorecards, through: :responses
  has_many :colors, through: :scorecards

  belongs_to :assigner, class_name: "User"
  belongs_to :assigned_post, class_name: "Post"
  belongs_to :level
  belongs_to :domain
  belongs_to :standard

  validates_presence_of :assigner_id, :level_id, :domain_id, :standard_id, :start_date, :end_date
  validates :assignee_ids, :presence => {:unless => "assignee_level", :message => "can't be blank"}

  after_create do 
    if !self.assignee_level.nil?
      self.assigner.authorized_users.where(grade: self.assignee_level).each do |student|
        Response.create!(assignment_id: self.id, :assignee_id => student.id)
      end
    end
    if !self.assigned_post.nil? && self.standard_id != self.assigned_post.standard_id
      self.assigned_post.update_attributes!(level_id: self.level_id, 
      domain_id: self.domain_id, standard_id: self.standard_id)
    end
  end  

end
