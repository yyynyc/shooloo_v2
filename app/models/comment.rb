class Comment < ActiveRecord::Base
  attr_accessible :content, :photo
  belongs_to :commented_post, class_name: "Post"
  belongs_to :commenter, class_name: "User"

  has_attached_file :photo, 
    :styles => {:large => "800x800>",
                :small => "60x60>"},                
    url: "/attachments/comments/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/comments/:id/:style/:basename.:extension"

  validates_presence_of :commented_post_id, :commenter_id,
            :content, :visible

  has_many :alarms, foreign_key: "alarmed_comment_id", dependent: :destroy
  has_many :likes, foreign_key: "liked_comment_id", dependent: :destroy
  has_many :likers, through: :likes, source: :liker

  def after_initialize
    @visible = true if @visible.nil?
  end

  def self.visible
    where(:visible=>true)
  end

  def self.hidden
    where(:visible=>false)
  end

  #default_scope order: 'comments.created_at DESC'

  after_save do 
    Post.update_all([
      "comments_count = (select count (*) from comments 
        where commented_post_id=?)", self.commented_post.id],
     	['id=?',self.commented_post.id])
  end

  before_save do
    if Comment.where(commenter_id: self.commenter_id, 
      commented_post_id: self.commented_post_id).blank?
      self.new_comment = "true"
    end
  end

  after_create do
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
  end

  after_destroy do 
    Post.update_all([
      "comments_count = (select count (*) from comments 
        where commented_post_id=?)", self.commented_post.id],
      ['id=?',self.commented_post.id])
    Event.create!(benefactor_id: self.commenter_id, 
      beneficiary_id: self.commented_post.user_id, 
      event: "delete comment", value: ShoolooV2::COMMENT_DELETE)
    if self.commented_post.user.admin? || self.commented_post.user.role == "teacher"
      Event.create!(benefactor_id: self.commenter_id, 
        beneficiary_id: self.commented_post.user_id, 
        event: "delete comment bounus", value: ShoolooV2::COMMENT_BONUS_DELETE)
    end
  end
end
