class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_enable :ganalytics, :opentrack, :clicktrack, :sbuscriptiontrack, :spamcheck

  default from: "Shooloo@fun.shooloo.org"

  def password_reset(user)
    sendgrid_category "password reset"
    @user = user
    unless @user.personal_email.blank? 
      mail to: user.personal_email, subject: "Shooloo Password Reset"
    end
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
    unless @user.personal_email.blank? 
      mail to: user.personal_email, 
        subject: "Your New Shooloo Account"
    end
  end

  def alarm_post(authorizer, alarmed_post, author)
    sendgrid_category "alarm notification to teacher"
    @user = authorizer
    @alarmed_post = alarmed_post
    @author = author
    mail to: authorizer.personal_email, 
        subject: "Shooloo Alarm on Your Student's Post"
  end

  def alarm_comment(authorizer, alarmed_comment, author)
    sendgrid_category "alarm notification to teacher"
    @user = authorizer
    @alarmed_comment = alarmed_comment
    @author = author
    mail to: authorizer.personal_email, 
        subject: "Shooloo Alarm on Your Student's Comment"
  end

  def alarmer(authorizer, alarmer)
    sendgrid_category "alarm notification to teacher"
    @user = authorizer
    @alarmer = alarmer
    mail to: authorizer.personal_email, 
        subject: "Your student has raised an alarm on Shooloo"
  end

  def auth_request(authorizer, authorized)
    sendgrid_category "authoriztaion request"
    @user = authorizer
    @authorized = authorized
      mail to: authorizer.personal_email, 
        subject: "Shooloo Authorization Request"
  end

  def auth_notify_yes(user)
    sendgrid_category "authorization approved"
    @user = user
    unless @user.personal_email.blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Approved Authorization from Shoooloo"
    end
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
    unless @user.personal_email.blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Authorization Declined from Shoooloo"
    end
  end

  def auth_delete(user)
    sendgrid_category "authorization removed"
    @user = user
    unless @user.personal_email.blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Authorization Removed from Shoooloo"
    end
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
    unless @user.personal_email.blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Approved Referral from Shoooloo"
    end
  end

  def ref_notify_no(user)
    sendgrid_category "referral declined"
    @user = user
    unless @user.personal_email.blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Referral Declined from Shoooloo"
    end
  end

  def invite_mail(invitemail)
    sendgrid_category "invitation mail"
    @invitemail = invitemail
    mail to: invitemail.to,
      from: "#{invitemail.user.full_name_us} (#{invitemail.user.personal_email})", 
      subject: invitemail.subject    
  end
end
