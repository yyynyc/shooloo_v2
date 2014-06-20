class Introduction < ActiveRecord::Base
  attr_accessible :introducer_id, :introducee_id, :introducer_email, :invitation_code
  belongs_to :introducee, class_name: "User"
  belongs_to :introducer, class_name: "User"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :introducer_email, format: { with: VALID_EMAIL_REGEX }, presence: true
  validate :valid_member, :valid_code, :no_self_intro

  def valid_member
  	if User.where(visible: true, personal_email: introducer_email).keep_if{
  		|u| u.role.in?(["teacher", "tutor", "parent", "other"])}.blank?
  	  errors.add(:introducer_email, "not found among Shooloo members")
  	end
  end

  def valid_code
    if !self.invitation_code.in?(["healthy2014", "AMTNJ2014"])
      errors.add(:invitation_code, "not valid")
    end
  end

  def no_self_intro
  	if self.introducer_email == self.introducee.personal_email
  		errors.add(:introducer_email, "can't be your own email")
  	end	
  end

  after_create do 
  	self.update_attributes!(introducer_id: User.find_by_personal_email(
  		self.introducer_email).id)  
    Activity.create!(action: "new", trackable: self, 
        user_id: self.introducee_id, recipient_id: self.introducer_id)
    unless self.introducer.admin? 
      self.introducer.point.advocacy += ShoolooV2::INTRO
      self.introducer.point.save!
    end
    self.introducee.point.advocacy += ShoolooV2::INTRO
    self.introducee.point.save!
  end
end
