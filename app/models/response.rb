class Response < ActiveRecord::Base
  attr_accessible :assignment_id, :assignee_id, :grade_id,
  	:completed, :graded, :max_mark, :reminders_count, :max_grading

  belongs_to :assignee, class_name: "User"
  belongs_to :assignment
  belongs_to :grade
 
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :gradings, through: :posts
  has_many :marks, through: :gradings
  has_one :scorecard, dependent: :destroy
  has_one :color, through: :scorecard
  has_many :reminders, foreign_key: "reminded_response_id", dependent: :destroy

  validates_uniqueness_of :assignee_id, scope: :assignment_id

  def max_mark
    if self.gradings.any?
      self.marks.max.full_mark
    elsif self.comments.any?
      if self.comments.map(&:mark).any?
        self.comments.map(&:mark).sort_by(&:mark).last.full_mark
      else
        return 0
      end
    else      
      return 0
    end
  end

  def max_grading
    if self.marks.any?
      self.marks.max.grading
    elsif self.comments.any?
      self.comments.joins(:grading, :mark).max.grading
    end
  end

  after_create do
  	if !self.assignee_id.nil?
  		Activity.create!(action: "assign", trackable: self, 
    		user_id: self.assignment.assigner_id, 
    		recipient_id: self.assignee_id)
  	end
    Scorecard.create!(response_id: self.id, color_id: 1)
  end 

  after_destroy do
    Scorecard.where(response_id: self.id).delete_all
  end
end
