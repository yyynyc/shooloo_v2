class Alarm < ActiveRecord::Base
  attr_accessible :alarmed_comment_id, :alarmed_post_id, :reason_ids, :alarmer_id
  belongs_to :alarmed_post, class_name: "Post"
  belongs_to :alarmed_comment, class_name: "Comment"
  belongs_to :alarmer, class_name: "User"
  has_many :alarm_reasons
  has_many :reasons, through: :alarm_reasons
  accepts_nested_attributes_for :alarm_reasons

  after_destroy do 
    if self.alarmed_post
      self.alarmed_post.state = "submitted"
      self.alarmed_post.save(validate: false)
      Event.create!(benefactor_id: self.alarmed_post.user_id, beneficiary_id: 1, 
        event: "unalarm post", value: ShoolooV2::UNALARM_POST)
    elsif self.alarmed_comment
      self.alarmed_comment.update_attributes!(visible: true)
      Event.create!(benefactor_id: self.alarmed_comment.commenter_id, beneficiary_id: 1, 
        event: "unalarm comment", value: ShoolooV2::UNALARM_COMMENT)
    end
  end

  after_create do
    if self.alarmed_post
      self.alarmed_post.update_attributes!(state: "draft", toreview: false)
      if !self.alarmed_post.check.nil?
        self.alarmed_post.check.destroy
      end
      if !self.alarmed_post.correction.nil?
        self.alarmed_post.correction.destroy
      end
      Event.create!(benefactor_id: self.alarmed_post.user_id, beneficiary_id: 1, 
        event: "alarm post", value: ShoolooV2::ALARM_POST)
      Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: self.alarmed_post.user_id)
    elsif self.alarmed_comment
      self.alarmed_comment.update_attributes!(visible: false)
      Event.create!(benefactor_id: self.alarmed_comment.commenter_id, beneficiary_id: 1, 
        event: "alarm comment", value: ShoolooV2::ALARM_COMMENT)
      Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: self.alarmed_comment.commenter_id)
      self.alarmed_comment.commenter.authorizers.each do |authorizer|
        Activity.create!(action: "create", trackable: self, 
        user_id: self.alarmer_id, recipient_id: authorizer.id)
        unless authorizer.personal_email.blank?
          UserMailer.alarm_comment(authorizer, self.alarmed_comment, 
            self.alarmed_comment.commenter).deliver
        end
      end
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
