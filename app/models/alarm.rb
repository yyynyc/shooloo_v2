class Alarm < ActiveRecord::Base
  attr_accessible :alarmed_comment_id, :alarmed_post_id
  belongs_to :alarmed_post, class_name: "Post"
  belongs_to :alarmed_comment, class_name: "Comment"
  belongs_to :alarmer, class_name: "User"

  after_save do 
  	if self.alarmed_post
      self.alarmed_post.update_attribute(:visible, false)
    elsif self.alarmed_comment
      self.alarmed_comment.update_attribute(:visible, false)
    end
  end

  after_destroy do 
    if self.alarmed_post
      Post.update_all(["visible=?", true], ['id=?',self.alarmed_post.id])
    elsif self.alarmed_comment
      Comment.update_all(['visible=?', true],['id=?',self.alarmed_comment.id])
    end
  end

  after_create do
    if self.alarmed_post
      Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: self.alarmed_post.user_id)
      self.alarmed_post.user.authorizers.each do |authorizer|
        Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: authorizer.id)
      end
    elsif self.alarmed_comment
      Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: self.alarmed_comment.commenter_id)
      self.alarmed_comment.commenter.authorizers.each do |authorizer|
        Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: authorizer.id)
      end
    end 
    self.alarmer.authorizers.each do |authorizer|
        Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: authorizer.id)
    end
    User.where(admin: true).each do |admin|
      Activity.create!(action: "create", trackable: self, 
      user_id: self.alarmer_id, recipient_id: admin.id)
    end
  end

  def correct_user
    current_user.admin? ||
    current_user.authorized_users.include?(alarm.alarmer) ||
    current_user == alarm.alarmer ||
    (current_user.authorized_users.include?(alarm.alarmed_post.user) if 
        !alarm.alarmed_post_id.nil?) ||
    (current_user.authorized_users.include?(alarm.alarmed_comment.commenter) if 
        !alarm.alarmed_comment_id.nil?) 
  end
end
