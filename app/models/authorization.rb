class Authorization < ActiveRecord::Base
  attr_accessible :authorizer_id, :approval, :authorized_id, :code

  belongs_to :authorized, class_name: "User"
  belongs_to :authorizer, class_name: "User"

  validates_presence_of :authorized_id, :authorizer_id, :approval

  after_create do
    if self.approval == "pending" && self.code.nil?
      Activity.create!(action: "create", trackable: self, 
      	user_id: self.authorized_id, recipient_id: self.authorizer_id)
      unless self.authorizer.personal_email.blank?      
        UserMailer.auth_request(self.authorizer, self.authorized).deliver
      end
    end
    if self.valid_code?
      self.update_attributes!(approval: "accepted")
    end
    if self.authorized.role == "student" && self.approval == "accepted"
      self.authorized.point.update_attributes!(competition: 30)
    end
  end

  after_update do
    if self.approval == "accepted"
      Activity.create!(action: "accept", trackable: self, 
        user_id: self.authorizer_id, recipient_id: self.authorized_id)
      if self.authorized.role == "student"
        self.authorized.point.update_attributes!(competition: 30)
      end
      if self.authorized.role == "teacher" && !self.authorized.personal_email.blank?
        UserMailer.auth_notify_yes(self.authorized).deliver
      elsif !self.authorized.personal_email.blank?
        UserMailer.auth_notify_yes_student(self.authorized).deliver
      end
      self.authorized.visible = "true"
      self.authorized.save(validate: false)
    elsif self.approval == "declined"
      Activity.create!(action: "decline", trackable: self, 
        user_id: self.authorizer_id, recipient_id: self.authorized_id)
      if !self.authorized.personal_email.blank?
        UserMailer.auth_notify_no(self.authorized).deliver
      end
      self.authorized.visible = "false"
      self.authorized.point.update_attributes!(competition: 0)
      self.authorized.save(validate: false)
    end     
  end

  after_destroy do
    if self.authorized.authorizations.where('approval' => "accepted").blank?
      self.authorized.visible = false
      self.authorized.save(validate: false)
      if !self.authorized.personal_email.blank?
        UserMailer.auth_delete(self.authorized).deliver
      end
    end
  end

  def valid_code?
    self.code.in?(["AMTNJ2014", "eMints2014", "BethHick"])
  end
end
