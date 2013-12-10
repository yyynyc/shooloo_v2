class Authorization < ActiveRecord::Base
  attr_accessible :authorizer_id, :approval, :authorized_id, :code

  belongs_to :authorized, class_name: "User"
  belongs_to :authorizer, class_name: "User"

  validates_presence_of :authorized_id, :authorizer_id, :approval
  #validates_inclusion_of :code, :in => %w(ATMNYS2013 ATMNYC2013 BethHick), 
    #allow_blank: true, message: "Code is invalid."

  after_create do
    if self.approval == "pending"
      Activity.create!(action: "create", trackable: self, 
      	user_id: self.authorized_id, recipient_id: self.authorizer_id)    
      UserMailer.auth_request(self.authorizer, self.authorized).deliver
    end
    if self.valid_code?
      self.update_attributes!(approval: "accepted")
    end
  end

  after_update do
    if self.approval == "accepted"
      Activity.create!(action: "accept", trackable: self, 
        user_id: self.authorizer_id, recipient_id: self.authorized_id)
      if self.authorized.role == "teacher"
        UserMailer.auth_notify_yes(self.authorized).deliver
      elsif !self.authorized.personal_email.nil?
        UserMailer.auth_notify_yes_student(self.authorized).deliver
      end
      self.authorized.visible = "true"
      self.authorized.save(validate: false)
    elsif self.approval == "declined"
      Activity.create!(action: "decline", trackable: self, 
        user_id: self.authorizer_id, recipient_id: self.authorized_id)
      if !self.authorized.personal_email.nil?
        UserMailer.auth_notify_no(self.authorized).deliver
      end
      self.authorized.visible = "false"
      self.authorized.save(validate: false)
    end     
  end

  after_destroy do
    if self.authorized.authorizations.where('approval' => "accepted").blank?
      self.authorized.update_attributes!(visible: false)
      if !self.authorized.personal_email.nil?
        UserMailer.auth_delete(self.authorized).deliver
      end
    end
  end

  def valid_code?
    self.code.in?(["ATMNYS2013", "ATMNYC2013", "BethHick"])
  end
end
