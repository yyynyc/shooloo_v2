class Referral < ActiveRecord::Base
  attr_accessible :referrer_id, :approval, :ref_checks_attributes, :ref_checks, :referred_id

  belongs_to :referred, class_name: "User"
  belongs_to :referrer, class_name: "User"

  validates_presence_of :referred_id, :referrer_id, :approval, on: :create
  #validates_presence_of :ref_checks, on: :update
  #validates_associated :ref_checks, on: :update

  has_many :ref_checks
  accepts_nested_attributes_for :ref_checks

  after_create do
    Activity.create!(action: "create", trackable: self, 
    	user_id: self.referred_id, recipient_id: self.referrer_id)
    if !self.referrer.personal_email.blank?
      UserMailer.ref_request(self.referrer).deliver
    end
  end

  after_update do
    if self.approval == "accepted"
      Activity.create!(action: "accept", trackable: self, 
      user_id: self.referrer_id, recipient_id: self.referred_id)
      unless self.referred.personal_email.blank?
        UserMailer.ref_notify_yes(self.referred).deliver
      end
    elsif self.approval == "declined"
      Activity.create!(action: "decline", trackable: self, 
      user_id: self.referrer_id, recipient_id: self.referred_id)
      unless self.referred.personal_email.blank?
        UserMailer.ref_notify_no(self.referred).deliver
      end
    end

    if self.referred.referrals.where('approval' => "accepted").any?
      self.referred.visible=true
      self.referred.save(validate: false)
    end
  end

  before_destroy do
    self.referred.visible=false
      self.referred.save(validate: false)
  end
end
