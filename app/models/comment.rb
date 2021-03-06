class Comment < ActiveRecord::Base
  
  attr_accessible :content, :photo, :commented_lesson_id, :response_id, 
    :graded, :visible, :opening, :commented_post_id
  
  belongs_to :commented_post, class_name: "Post"
  belongs_to :commented_lesson, class_name: "Lesson"
  belongs_to :commenter, class_name: "User"
  belongs_to :response

  has_attached_file :photo, 
    :styles => {:large => "800x800>",
                :small => "60x60>"},                
    url: "/attachments/comments/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/comments/:id/:style/:basename.:extension"

  validates_presence_of :commenter_id, :opening
  validate :comment_custom

  has_one :alarm, foreign_key: "alarmed_comment_id", dependent: :destroy
  has_many :likes, foreign_key: "liked_comment_id", dependent: :destroy
  has_many :likers, through: :likes, source: :liker
  has_one :grading, foreign_key: "graded_comment_id", dependent: :destroy
  has_one :grader, through: :grading, dependent: :destroy
  has_one :mark, through: :grading
  has_one :scorecard
  has_one :color, through: :scorecard

  def comment_custom
    if !commented_post_id.nil?
      if content.downcase =~ /[a-df-qs-w][^\s]/
        errors.add(:content, "can only include mathematical expressions. It can't contain any words or space.")
      end
    end
  end

  def after_initialize
    @visible = true if @visible.nil?
  end

  def self.visible
    where(:visible=>true)
  end

  def self.hidden
    where(:visible=>false)
  end

  before_save do
    if Comment.where(commenter_id: self.commenter_id, 
      commented_post_id: self.commented_post_id).blank?
      self.new_comment = "true"
    end
  end

  after_create do
    if !self.commented_post.nil?
      unless self.commenter_id == self.commented_post.user_id
        Activity.create!(action: "create", trackable: self, 
          user_id: self.commenter_id, recipient_id: self.commented_post.user_id)
        if self.new_comment?
          Event.create!(benefactor_id: self.commenter_id, 
            beneficiary_id: self.commented_post.user_id, 
            event: "new comment", value: ShoolooV2::COMMENT_NEW)
          if self.commented_post.user.admin? || self.commented_post.user.role == "teacher"
            Event.create!(benefactor_id: self.commenter_id, 
              beneficiary_id: self.commented_post.user_id, 
              event: "comment bonus", value: ShoolooV2::COMMENT_BONUS)
          end
        end
      end
      if self.commented_post.comments.count > 1
        self.commented_post.commenters.uniq.each do |c|
          Activity.create!(action: "create", trackable: self, 
            user_id: self.commenter_id, recipient_id: c.id)
        end
      end
      if !self.response.nil?
        self.response.update_attributes!(completed: true)
        Activity.create!(action: "complete", trackable: self.response, 
          user_id: self.commenter_id, recipient_id: self.response.assignment.assigner_id)
      end
    elsif !self.commented_lesson.nil?
      unless self.commenter_id == self.commented_lesson.user_id
        Activity.create!(action: "teacher_create", trackable: self, 
          user_id: self.commenter_id, recipient_id: self.commented_lesson.user_id)
        Event.create!(benefactor_id: self.commenter_id, 
          beneficiary_id: self.commented_lesson.user_id, 
          event: "new comment", value: ShoolooV2::COMMENT_NEW)
      end
      if self.commented_lesson.comments.count > 1
        self.commented_lesson.commenters.uniq.each do |c|
          Activity.create!(action: "teacher_create", trackable: self, 
            user_id: self.commenter_id, recipient_id: c.id)
        end
      end          
    end
  end

  after_destroy do
    if !self.response.nil?
      self.response.update_attributes!(completed: false)
    end
    Grading.where(graded_comment_id: self.id).delete_all
  end
end
