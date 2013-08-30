class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_enable :ganalytics, :opentrack, :clicktrack, :sbuscriptiontrack, :spamcheck

  default from: "Shooloo@fun.shooloo.org"

  def password_reset(user)
    sendgrid_category "password reset"
    @user = user
    mail to: user.personal_email, subject: "Shooloo Password Reset"
  end

  def parental_consent(user)
    sendgrid_category "parental consent"
    @user = user
    mail to: user.parent_email, 
        subject: "Confirm Your Child's Membership of Shooloo (a math program)"
  end

  def activity_alert(user)
    sendgrid_category "activity alerts"
    @user = user
    unless @user.personal_email.blank? || 
        Activity.where(read: nil, recipient_id: @user.id).blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Your Activity Alerts From Shooloo"
    end
  end

  def sign_up_confirm(user)
    sendgrid_category "sign up confirmation"
    @user = user
    mail to: user.personal_email, 
        subject: "Your New Shooloo Account"
  end

  def auth_request(user)
    sendgrid_category "authoriztaion request"
    @user = user
    mail to: user.personal_email, 
        subject: "Shooloo Authorization Request"
  end

  def auth_notify_yes(user)
    sendgrid_category "authorization approved"
    @user = user
    mail to: user.personal_email, 
        subject: "#{user.first_name}: Approved Authorization from Shoooloo"
  end

  def auth_notify_yes_student(user)
    sendgrid_category "authorization approved"
    @user = user
    unless user.personal_email.nil?
      mail to: user.personal_email, 
          subject: "#{user.first_name}: Approved Authorization from Shoooloo"
    end
  end

  def auth_notify_no (user)
    sendgrid_category "authorization declined"
    @user = user
    mail to: user.personal_email, 
        subject: "#{user.first_name}: Authorization Declined from Shoooloo"
  end

  def auth_delete(user)
    sendgrid_category "authorization removed"
    @user = user
    mail to: user.personal_email, 
        subject: "#{user.first_name}: Authorization Removed from Shoooloo"
  end

  def ref_request(user)
    sendgrid_category "referral request to admin"
    @user = user
    mail to: user.personal_email, 
        subject: "Shooloo Referral Request"
  end

  def ref_notify_yes(user)
    sendgrid_category "referral approved"
    @user = user
    mail to: user.personal_email, 
        subject: "#{user.first_name}: Approved Referral from Shoooloo"
  end

  def ref_notify_no (user)
    sendgrid_category "referral declined"
    @user = user
    mail to: user.personal_email, 
        subject: "#{user.first_name}: Referral Declined from Shoooloo"
  end
end
